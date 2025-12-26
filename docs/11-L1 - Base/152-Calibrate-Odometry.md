# Calibrating wheel odometry

Calibrating wheel odometry is one of those tasks that looks simple on paper but becomes surprisingly subtle once you want drift-free, repeatable results.

Below is a calibration workflow used in research labs and industry. It works for differential-drive, skid-steer, and even mecanum robots (with small adjustments).

## Motor unit

520 DC Gear Motor: Comes with an encoder for precise speed and position control. Available in different RPM variants (205, 333, 550).

![md520](images/md520.png)

### Encoder output description

The phase difference between the two signals is 100 degrees, and the rotation direction of the motor can be judged according to the sequence of the two signals. The current tire walking distance can be calculated according to the number of signal pulses per unit time and the tire circumference. If only the number of AB-phase pulses per unit time is detected, the speed and slowness of the current motor speed can also be measured.

Take a motor with a reduction ratio of 1:56 as an example, the single-phase output of 11 pulses when the motor rotates one circle, and with a reduction ratio of 1:56, the maximum output of the output shaft of the gear rotates one circle $(56*11*4) = 2464$ counts. The phase difference of AB two-phase output pulse signal is 100 degrees, which can detect the rotation direction of the motor.

![md529](images/md529a.png)

!!! tip "What “ticks per revolution” actually means"
      There are two different revolutions in your drivetrain:
      * Motor shaft revolution
      * Wheel revolution (after gearbox)
      Encoders are almost always mounted on the motor shaft, not the wheel.
      So:
      * The encoder measures motor revolutions
      * The robot moves based on wheel revolutions

## Calibration model

### Identify the Parameters to Calibrate

For a mecanum‑drive robot, the core parameters are:

- `wheel_radius` Wheel radius
- `wheel_separation_width` Wheel separation (track width)
- `wheel_separation_length` Wheel separation (track length)
- `ticks_per_revolution` : Ticks per revolution of the wheel including the gearbox
- `front_left_scale` Per-wheel calibration multipliers front left
- `front_right_scale` Per-wheel calibration multipliers front right
- `rear_left_scale` Per-wheel calibration multipliers rear left
- `rear_right_scale` Per-wheel calibration multipliers rear right

### Background

Why scale factors belong ONLY in odometry Wheel scale factors correct physical differences between wheels:

- roller wear
- slight radius differences
- gearbox friction
- encoder inconsistencies

These differences affect how far the robot actually moves, not what you command it to do.

### Adjustment of the kinematics

We need to adjust the calculation to consider the correction factors. 

``` python
dfl = (front_left_encoder - self.front_left_encoder_old) / self.compute_ticks_per_meter() * self.front_left_scale
dfr = (front_right_encoder - self.front_right_encoder_old) / self.compute_ticks_per_meter() * self.front_right_scale
drl = (rear_left_encoder - self.rear_left_encoder_old) / self.compute_ticks_per_meter() * self.rear_left_scale
drr = (rear_right_encoder - self.rear_right_encoder_old) / self.compute_ticks_per_meter() * self.rear_right_scale
```

Each wheel scale factor corrects the effective wheel circumference, which directly affects:

- how far the wheel actually travels per encoder tick
- how much distance you compute from encoder deltas

So the scale factor must be applied after converting ticks → meters, but before feeding the distances into the mecanum kinematics.

<!-- ## Step 1 - Check Roller Angle

Most mecanum wheels are 45$^0$. Some industrial wheels use 60$^0$.

You can verify by measuring the angle of a roller relative to the wheel axis.

If you bought standard 45$^0$ wheels, you can safely set:

``` yaml
roller_angle: 0.78539816339
``` -->

## Check encoder ticks per revolution (of the gear box)

Most MD520Z56 motors come with a Hall-effect quadrature encoder that provides:

- 11 pulses per motor revolution (PPR)
- When decoded in quadrature (×4), this becomes: $11×4=44$ counts per motor revolution
- So the effective counts per wheel revolution are:
   $counts per wheel rev=44×gear ratio$

MD520Z56-12V Motor unit has $(56*11*4) = 2464$ counts, you can safely set:

``` yaml
ticks_per_revolution: 2464
```

### How to verify your exact encoder resolution

You can confirm it in 10 seconds:

- Rotate the wheel exactly one full turn by hand.
- Read the encoder tick change from your microcontroller or ROS topic.
- That number is your true counts per wheel revolution.

This automatically includes:

- encoder CPR
- quadrature decoding
- gear ratio
- any driver scaling

It’s the most reliable method.

## Wheel Separation Width (left - right)

### What you need

- Tape measure
- Robot on a flat surface

### Procedure

1. Measure the distance between the contact points of the left and right wheels.
2. For mecanum wheels, the contact point is the center of the wheel hub, not the roller tips.

So:

$$ {\text{wheel\_separation\_width}} = \text{distance between left and right wheel centers} $$

This is usually stable unless your frame flexes.

## Calibrate Wheel Radius (Linear Motion Test)

### Goal

Ensure that commanded linear velocity matches actual linear motion.

<!-- ### What you need

- Calipers or a ruler
- A flat surface
- A way to command a constant wheel velocity -->

### Procedure  

1. Place the robot on a long, straight, flat surface.
2. Command a **pure forward velocity** (e.g., `0.2 m/s`) for a fixed time (e.g., 10 seconds).
3. Measure the **actual distance traveled** with a tape measure or motion capture.
4. Compute the scaling factor:

$$
k_r = \frac{\text{actual distance}}{\text{odometry distance}}
$$

5. Multiply your wheel radius by $k_r$.

### Why this matters

Even tiny manufacturing differences (1–2 mm in wheel diameter) cause large drift over time. This gives you the effective radius including roller compression.

## Calibrate Wheel Separation (front - rear) (Rotation Test)

### Goal

Ensure that commanded angular velocity matches actual rotation.

### Procedure

1. Command a **pure rotation** (e.g., `0.3 rad/s`) for a fixed time.
2. Measure the **actual angle turned** using:
   - A large protractor on the floor
   - A printed circle
   - A motion capture system
   - A smartphone compass (surprisingly decent)

3. Compute the scaling factor:

$$
k_s = \frac{\text{actual angle}}{\text{odometry angle}}
$$

4. Multiply your `wheel_separation` by the factor $k_s$.

### Why this matters

Track width is almost never the nominal CAD value once you include tire deformation, load, and friction.

## Correct Left/Right Asymmetry

Even after radius and separation calibration, robots often **curve slightly** during straight motion.

### Procedure

1. Command a long straight drive (3–5 m).
2. Measure lateral drift.
3. Adjust:

- `front_left_scale`
- `front_right_scale`
- `rear_left_scale`
- `rear_right_scale`

4. Repeat until straight motion is stable.

!!! tip Important
      This is the single most important calibration for mecanum robots.

### Rule of thumb

If the robot drifts **right**, the **left wheel** is effectively “larger” → reduce its multiplier slightly. Adjust by small increments (0.5–1%).

## Validate with a Square Path Test

Drive a square:

- 1 m forward  
- 90$^0$ turn  
- Repeat 4 times  

Check:

- Does the robot return close to the starting point?
- Is the final heading correct?

If not:

- Position error $\to$ wheel radius
- Heading error $\to$ wheel separation
- Curved edges $\to$ left/right multipliers

## Optional — Slip Compensation

You measure these empirically:

- Drive forward $\to$ measure drift in Y $\to$ adjust slip_y
- Drive sideways $\to$ measure drift in X $\to$ adjust slip_x
- Rotate $\to$ measure drift in X/Y $\to$ adjust slip_yaw

These are fine-tuning parameters.

## Optional — Use ROS 2 Tools for Automation

If you want to integrate this into your reproducible workflow:

- Log `/odom` and `/tf`
- Use a Jupyter notebook (fits your Pixi/Jupyter setup)
- Compute scaling factors automatically
- Store calibration in YAML (fits your modular config style)

## A Few Expert Tips

- **Mecanum?** You must calibrate each wheel separately.
- **Jetson Orin Nano + depth camera?** Fuse wheel odometry with visual odometry to reduce drift.
