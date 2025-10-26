# Understanding LO and LIO

## LO (Lidar Odometry):

Lidar Odometry (LO) is the process of estimating a robot's motion over time by analyzing sequential Lidar scans. It typically involves matching consecutive pointclouds to determine the relative transformation (translation and rotation) between them. LO methods often rely on features like edges or planes extracted from the 3D scans, or perform direct point-to-point or point-to-plane alignment, as seen in ICP (Iterative Closest Point)-based techniques. Since Lidar sensors are highly accurate in measuring distances, LO tends to be robust to environmental variations like lighting changes, but it can struggle in areas with poor geometric structure (e.g., large open spaces).

## LIO (Lidar-Inertial Odometry):

Lidar-Inertial Odometry (LIO) tightly or loosely couples Lidar data with Inertial Measurement Unit (IMU) data to estimate motion more accurately and robustly. By integrating high-frequency IMU measurements (which provide rapid estimates of acceleration and angular velocity) with Lidar scans (which offer detailed spatial information), LIO systems can compensate for Lidar's relatively low scan rate and poor performance during fast motion. IMU data helps predict motion between scans and improves resilience against Lidar degradation (e.g., in featureless environments), making LIO particularly powerful for aggressive maneuvers and high-speed robotics applications.

## Differences:

The main difference between LO and LIO lies in the use of additional sensor data: LO relies solely on Lidar scans, while LIO fuses Lidar and IMU measurements. LO is simpler to implement and tune, but is more vulnerable to drift and failure when Lidar-only matching becomes unreliable (such as in feature-sparse areas or during fast motion). LIO, on the other hand, is more complex and computationally heavier but provides significantly improved robustness, accuracy, and temporal resolution by incorporating motion prediction and correction from inertial sensing.

## When to use each?

Use LO when your robot moves relatively slowly or operates in well-structured environments (e.g., indoors with abundant features like walls and furniture), and when system simplicity or computational resources are limited. LIO should be used when high robustness and accuracy are needed — especially in high-speed, high-dynamic, or less structured environments (e.g., drones, autonomous cars, outdoor robots). LIO is preferred in cases where short-term motion needs to be accurately captured even when Lidar information is sparse or degraded.

## References

[Understanding LO and LIO](https://www.slambotics.org/blog/what-is-lio)