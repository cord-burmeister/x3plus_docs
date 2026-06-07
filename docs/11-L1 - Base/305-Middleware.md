# Middleware in ROS 2

## What Is Middleware in ROS 2?

Middleware in ROS 2 refers to the communication infrastructure that enables nodes (individual components of a robot system) to exchange data. This includes publishing/subscribing to topics, calling services, and sending actions.

## Key Middleware Concepts

- **RMW (ROS Middleware Interface)**:  
  Acts as an abstraction layer between ROS 2 and the underlying middleware. It allows ROS 2 to support multiple middleware implementations without changing the core APIs.

- **DDS (Data Distribution Service)**:  
  The default and most widely used middleware in ROS 2. DDS is a standardized protocol for real-time, scalable, and reliable data exchange. It supports features like QoS (Quality of Service), discovery, and security.

- **Fast DDS**:  
  A popular DDS implementation used in ROS 2 LTS releases. Known for its performance and configurability.

- **Alternative Middleware Options**:  
  While DDS is the default, ROS 2 also supports other middleware like:
  - **Cyclone DDS**
  - **Connext DDS**
  - **Zenoh** – Recently selected as a promising alternative for future ROS 2 releases due to its lightweight and flexible architecture.

## Why DDS?

ROS 2 adopted DDS to:

- Leverage an existing, mature standard
- Enable real-time communication
- Support distributed systems
- Avoid reinventing the wheel with custom protocols (as in ROS 1)

## Switching Middleware

Developers can switch between middleware implementations depending on:

- Platform compatibility
- Performance needs
- Network conditions
- Licensing constraints

## Bonus Insight

Latency in ROS 2 is highly influenced by the DDS middleware you choose. Studies show that default ROS 2 configurations can introduce up to 50% overhead compared to raw DDS communication. So if you're building a distributed system, middleware tuning is just as important as tool selection.

## Configure Cyclone DDS

Setting the Environment variable for the configured middleware.

``` bash
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
```

All setup script contain the logic to set the `export`statement in the .bashrc file.

``` bash
# Add RMW_IMPLEMENTATION to use cyclonedds as default middleware
if (grep -q "export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp" /home/$USER/.bashrc ); then
    echo "RMW_IMPLEMENTATION already set in .bashrc"
else
    echo "export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp" >> /home/$USER/.bashrc
fi
```

Each bringup package contains the dependcy statement in the package.xml file

``` XML
  <depend>rmw_cyclonedds_cpp</depend>
```

## References

[DDS tuning information](https://docs.ros.org/en/rolling/How-To-Guides/DDS-tuning.html): This page provides some guidance on parameter tunings that were found to address issues faced while using various DDS implementations on Linux in real-world situations

[Working with multiple ROS 2 middleware implementations](https://docs.ros.org/en/rolling/How-To-Guides/Working-with-multiple-RMW-implementations.html): DDS and RMW implementations can be added to your workspace by installing the necessary dependencies and rebuilding the workspace

[2023-09 ROS2 RMW alternate](https://discourse.openrobotics.org/uploads/short-url/o9ihvSjCwB8LkzRklpKdeesRTDi.pdf): This paper will present the challenges of the current system, then derive and propose a set of
requirements that a middleware must meet in order to be considered for a new RMW.

[Comparing the Performance of Zenoh, MQTT, Kafka, and DDS](https://zenoh.io/blog/2023-03-21-zenoh-vs-mqtt-kafka-dds/): In this blog, we’ll present an evaluation conducted by the National Taiwan University where Zenoh's performance is compared with MQTT, Kafka, and DDS.

[Impact of ROS 2 Node Composition in Robotic Systems](https://arxiv.org/pdf/2305.09933):  This paper explores and benchmarks one of these new node types- the Component node which allows nodes to be composed manually or dynamically into processes while retaining separation of concerns in a codebase for distributed development.

[Exploring the Performance of ROS2](https://dl.acm.org/doi/pdf/10.1145/2968478.2968502): ROS2 must convert data for DDS and abstract DDS from its users; however, this incurs additional over head, which is examined in this study.

[ROS 2 Performance Benchmarking](https://discourse.openrobotics.org/t/ros-2-performance-benchmarking/44382)
