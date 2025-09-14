# NVIDIA Jetson Models

## NVIDIA Jetson Model Comparison

Here's a snapshot of the major Jetson modules, from entry-level to cutting-edge:

| Model                  | AI Performance | Memory       | Power Usage | Target Use Case                          |
|------------------------|----------------|--------------|-------------|------------------------------------------|
| **Jetson Nano**        | ~0.5 TOPS      | 4 GB         | ~5–10 W     | Basic AI, IoT, hobbyist projects         |
| **Jetson TX2**         | ~1.3 TOPS      | 8 GB         | ~7.5–15 W   | Industrial edge AI, drones               |
| **Jetson Xavier NX**   | ~21 TOPS       | 8–16 GB      | ~10–15 W    | Smart cameras, compact robotics          |
| **Jetson AGX Xavier**  | ~32 TOPS       | 32–64 GB     | ~15–30 W    | Autonomous machines, advanced robotics   |
| **Jetson Orin Nano**   | Up to 67 TOPS  | 4–8 GB       | ~7–25 W     | Entry-level edge AI with high efficiency |
| **Jetson Orin NX**     | Up to 157 TOPS | 8–16 GB      | ~10–40 W    | Mid-range robotics, multi-sensor systems |
| **Jetson AGX Orin**    | Up to 275 TOPS | 32–64 GB     | ~15–60 W    | High-performance robotics, AI pipelines  |
| **Jetson AGX Thor**    | Up to 2070 TFLOPS (FP4) | 128 GB | ~40–130 W   | Humanoid robots, generative AI at edge   |

## Current Demand Trends

The Jetson ecosystem is booming, especially in these areas:

### 1. **Humanoid Robotics & Physical AI**

- The newly launched **Jetson AGX Thor** is the most advanced yet, powering real-time reasoning and generative AI models directly on-device.
- Companies like **Boston Dynamics**, **Amazon Robotics**, and **Agility Robotics** are already integrating Thor into their next-gen robots.

### 2. **Industrial Automation**

- **Jetson Orin NX** and **AGX Orin** are widely adopted for smart factories, logistics, and autonomous machines due to their balance of power and efficiency.

### 3. **Edge AI & Vision Systems**

- **Jetson Orin Nano** is becoming the go-to for compact, low-power deployments with surprisingly high AI throughput—ideal for smart cameras, drones, and mobile robots.

### 4. **Education & Prototyping**

- **Jetson Nano** remains popular for learning and prototyping, though its performance is now dwarfed by newer models.

## Why Jetson Is Dominating

- **Unified software stack**: JetPack SDK and CUDA-X make development seamless across models.
- **Scalability**: Developers can prototype on Nano or Xavier NX and scale up to Orin or Thor without rewriting code.
- **Ecosystem**: Over 2 million developers and 150+ partners are building on Jetson.
