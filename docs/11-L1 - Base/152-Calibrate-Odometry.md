# Calibrating wheel odometry

Calibrating wheel odometry is one of those tasks that looks simple on paper but becomes surprisingly subtle once you want drift‑free, repeatable results.

Below is a calibration workflow used in research labs and industry. It works for differential‑drive, skid‑steer, and even mecanum robots (with small adjustments).

## 1. Identify the Parameters to Calibrate

For a differential‑drive robot, the core parameters are:

- **Wheel radius (or diameter)**
- **Wheel separation (track width)**
- **Encoder ticks per revolution**
- **Left/right wheel scaling factors** (to compensate for mechanical asymmetry)

In ROS 2, these map to:

- `wheel_radius`
- `wheel_separation`
- `left_wheel_radius_multiplier`
- `right_wheel_radius_multiplier`

## 2. Step 1 — Calibrate Wheel Radius (Linear Motion Test)

### Goal

Ensure that commanded linear velocity matches actual linear motion.

### Procedure  

1. Place the robot on a long, straight, flat surface.
2. Command a **pure forward velocity** (e.g., `0.2 m/s`) for a fixed time (e.g., 10 seconds).
3. Measure the **actual distance traveled** with a tape measure or motion capture.
4. Compute the scaling factor:

\[
k_r = \frac{\text{actual distance}}{\text{odometry distance}}
\]

5. Apply this factor to both wheel radii (or to the wheel multipliers).

### Why this matters

Even tiny manufacturing differences (1–2 mm in wheel diameter) cause large drift over time.

---

# 3. 🔄 Step 2 — Calibrate Wheel Separation (Rotation Test)

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

\[
k_s = \frac{\text{actual angle}}{\text{odometry angle}}
\]

4. Multiply your `wheel_separation` by this factor.

### Why this matters  
Track width is almost never the nominal CAD value once you include tire deformation, load, and friction.

---

# 4. ⚖️ Step 3 — Correct Left/Right Asymmetry

Even after radius and separation calibration, robots often **curve slightly** during straight motion.

### Procedure  
1. Command a long straight drive (3–5 m).
2. Measure lateral drift.
3. Adjust:

- `left_wheel_radius_multiplier`
- `right_wheel_radius_multiplier`

until drift is minimized.

### Rule of thumb  
If the robot drifts **right**, the **left wheel** is effectively “larger” → reduce its multiplier slightly.

---

# 5. 🧭 Step 4 — Validate with a Square Path Test

Drive a square:

- 1 m forward  
- 90° turn  
- Repeat 4 times  

Check:

- Does the robot return close to the starting point?
- Is the final heading correct?

If not:

- Position error → wheel radius
- Heading error → wheel separation
- Curved edges → left/right multipliers

---

# 6. 🧰 Optional — Use ROS 2 Tools for Automation

If you want to integrate this into your reproducible workflow:

- Log `/odom` and `/tf`
- Use a Jupyter notebook (fits your Pixi/Jupyter setup)
- Compute scaling factors automatically
- Store calibration in YAML (fits your modular config style)

I can help you generate a reusable calibration notebook or YAML template if you want.

---

# 7. 🧠 A Few Expert Tips

- **Inflatable wheels?** Recalibrate often. Pressure changes radius.
- **Skid‑steer?** Expect more drift; calibrate under load.
- **Mecanum?** You must calibrate each wheel separately.
- **Jetson Orin Nano + depth camera?** Fuse wheel odometry with visual odometry to reduce drift.

