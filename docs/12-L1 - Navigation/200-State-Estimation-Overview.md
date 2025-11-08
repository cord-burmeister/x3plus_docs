# State Estimation

## What Is State Estimation?

State estimation is the process of inferring the internal state of a system (like a robot’s position, velocity, orientation, etc.) from noisy, indirect, or incomplete sensor measurements. It’s essential for enabling autonomous navigation, mapping, control, and decision-making.

### Core Techniques in State Estimation

| Technique | Description | Strengths | Limitations |
|----------|-------------|-----------|-------------|
| **Kalman Filter (KF)** | Optimal for linear systems with Gaussian noise. | Fast, efficient, well-understood. | Assumes linearity and Gaussian noise. |
| **Extended Kalman Filter (EKF)** | Linearizes non-linear models around current estimate. | Widely used in robotics (e.g., SLAM). | Linearization can introduce errors. |
| **Unscented Kalman Filter (UKF)** | Uses deterministic sampling (sigma points) for better non-linear handling. | More accurate than EKF for non-linear systems. | More computationally intensive than EKF. |
| **Particle Filter (Monte Carlo Localization)** | Uses a set of weighted samples (particles) to represent belief distribution. | Handles non-linear, non-Gaussian systems well. | Computationally expensive, especially in high dimensions. |
| **Bayesian Filters** | General probabilistic framework (includes KF, PF, etc.). | Flexible, handles uncertainty well. | Can be complex to implement and tune. |
| **Least Squares Estimation** | Minimizes the sum of squared errors between predicted and observed values. | Simple, effective for batch problems. | Not ideal for real-time or dynamic systems. |

### Advanced and Hybrid Approaches

- **Sensor Fusion**: Combines data from multiple sensors (e.g., IMU + GPS + LiDAR) to improve accuracy and robustness.
- **SLAM (Simultaneous Localization and Mapping)**: Estimates both the robot’s pose and the map of the environment concurrently.
- **Invariant Neural Filters**: Leverage machine learning to enhance estimation, especially in legged or dynamic robots.

### Challenges in State Estimation

- Sensor noise and bias
- Non-linear dynamics
- High-dimensional state spaces
- Real-time constraints
