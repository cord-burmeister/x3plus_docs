
# Robot localization


## Overview

Odometry is the process of estimating a robot’s position, orientation, and velocity over time using onboard sensors. It’s a foundational technique for navigation and localization, especially in mobile robotics.

### How It Works

- **Wheel Encoders**: Measure wheel rotations to infer linear and angular displacement.
- **IMUs (Inertial Measurement Units)**: Track acceleration and angular velocity.
- **Visual Odometry**: Uses camera data to estimate motion by analyzing changes in the visual scene.
- **Sensor Fusion**: Combines multiple sources (e.g., wheel + IMU + GPS) for more robust estimates.

### Types of Odometry

| Type              | Sensors Used         | Strengths                            | Limitations                            |
|-------------------|----------------------|--------------------------------------|----------------------------------------|
| Wheel Odometry    | Encoders             | Simple, low-cost                     | Accumulates error over time            |
| Visual Odometry   | Cameras              | Works in GPS-denied environments     | Sensitive to lighting and texture      |
| Inertial Odometry | IMUs                 | Fast response, no external input     | Drift without correction               |

### Common Errors

- **Systematic**: Calibration issues (e.g., wheel diameter mismatch).
- **Non-Systematic**: Environmental factors (e.g., wheel slippage, uneven terrain).

Odometry is often combined with SLAM (Simultaneous Localization and Mapping) or external references like GPS to correct drift and improve long-term accuracy.

## Odometry

Odometry systems estimate a robot’s pose and velocity based on its motion. These estimates are obtained from various sensors, including IMUs, LIDAR, RADAR, VIO, and wheel encoders. It’s important to note that IMUs tend to drift over time, while wheel encoders drift over the distance traveled. As a result, these sensors are often used together to mitigate each other’s limitations.

The odometry frame (often referred to as ‘odom frame’) and its associated transformation are used by a robot’s odometry system to continuously publish localization information. However, this information becomes less accurate over time or distance due to sensor modalities and drift effects. Despite this limitation, the robot can still utilize this data for immediate navigation tasks, such as collision avoidance. To maintain consistently accurate odometry information over extended periods, the map frame provides globally accurate data that is used to correct any inaccuracies in the odom frame.



## References

[Setting Up Odometry](https://docs.nav2.org/setup_guides/odom/setup_odom.html)

[Sensor Noise Model](https://classic.gazebosim.org/tutorials?tut=sensor_noise)

[Robot Localization Documentation](https://docs.ros.org/en/noetic/api/robot_localization/html/index.html)

[Robot Localization: An Introduction](https://onlinelibrary.wiley.com/doi/full/10.1002/047134608X.W8318?msockid=3aab05a854346f9505e6111655b16e96)

[Localization strategies for autonomous mobile robots: A review](https://www.sciencedirect.com/science/article/pii/S1319157821000550)

[Overview of robot localization strategies](https://kshitijtiwari.com/all-resources/mobile-robots/robot-localization/)