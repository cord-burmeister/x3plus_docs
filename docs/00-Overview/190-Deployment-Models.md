# Deployment Models

Deployment models refer to the various ways in which software applications can be deployed and made available to users. The deployment models reflect the flow of development which move from software to the hardware. Here are some common deployment models:

## ROS Deployment Models

### 1. Simulation (Sim)

In simulation deployment, all ROS nodes run on a desktop or server, often using tools like Gazebo or RViz to simulate the robot and its environment. This is used for development, testing, and validation before deploying to real hardware.

**Pros:**  

- Safe and cost-effective for testing  
- Easy to iterate and debug

**Cons:**  

- May not capture all real-world complexities  
- Performance may differ from real hardware

### 2. Hardware-in-the-loop Deployment (HIL)

Hardware-in-the-loop (HIL) deployment is a hybrid testing and deployment model where parts of the system run on real hardware while other parts are simulated. HIL is commonly used to validate control, interfaces, and safety behavior under realistic timing and sensor/actuator conditions without exposing full production hardware to risk.

**Pros:**

- Validate integration between real sensors/actuators and the control software
- Test hardware drivers and timing-sensitive code under controlled conditions
- Exercise failure modes and safety systems without risking the complete system
- Reproduce intermittent or environment-dependent faults by combining recorded sensor traces with live hardware

**Cons:**  

- Limited by onboard hardware resources  
- Harder to update or monitor remotely

### 3. Distributed with Calculation Backend (Calc)

Here, the robot runs a subset of ROS nodes locally (e.g., for sensor data acquisition and basic control), while offloading heavy computation (such as SLAM, object recognition, or planning) to a remote backend server, often over a network. This allows for more complex processing than the robot could handle alone.

**Pros:**

- Access to greater computational resources  
- Easier to update and monitor backend algorithms

**Cons:**

- Dependent on network connectivity and bandwidth  
- Potential for increased latency

### 4. Autonomous with Teleoperation (Teleop)

In this model, the robot operates autonomously for most tasks but allows a human or computer operator to intervene or take control remotely when needed. Teleoperation can be used for supervision, troubleshooting, or handling complex situations that the robot cannot resolve on its own. Communication is typically established over a network, enabling real-time or near-real-time control and feedback.

**Pros:**

- Combines autonomy with human oversight  
- Increases safety and flexibility  
- Enables remote troubleshooting and support

**Cons:**

- Requires reliable network connectivity for teleoperation  
- May introduce latency during manual control  
- Human intervention may be needed in unexpected scenarios

### 5. Totally Autonomous (Auto)

In this model, all ROS nodes and computation run directly on the robot’s onboard computer(s). The robot operates independently, without relying on external servers or networks. This is ideal for scenarios where connectivity is unreliable or unavailable, and low-latency, real-time processing is required.

**Pros:**

- No dependency on external infrastructure  
- Low latency  
- High reliability in disconnected environments

**Cons:**  

- Limited by onboard hardware resources  
- Harder to update or monitor remotely

These models can be combined or adapted depending on the application requirements and available resources.

## Mapping of repositories to deployment models

| Name | Hardware | Environment | Role | Repos |
| ---- | -------- | ----------- | ---- | ----- |
| Sim | B760 | Native Ubuntu | Development Machine | x3plus </br> x3plus_gz |
| HIL | ma3jet | Native Ubuntu | Robot Controller | x3plus |
| | B760 | Native Ubuntu | Development Machine | x3plus_gz |
| robot | ma3jet | Native Ubuntu | Robot Controller | x3plus </br> x3plus_bot </br> x3plus_driver |
| cockpit | small-laptop | Native Ubuntu | Teleoperation | x3plus_pit |
