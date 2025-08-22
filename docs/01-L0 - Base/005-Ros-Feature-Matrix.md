# Feature availability Matrix

One of the biggest learnings in the usage of ROS and ROS 2 is to keep track of the available packages and functionality based on the distribution you choose and the combination of tools or packages. 

This is the approach to keep track of the findings. Due to the fact that i am using *humble* as ROS 2 distribution and *harmonic* gazebo as simulation, some statements for other distributions are based on documentation not experience. 

## Feature Matrix ROS

The following table is a list of topis which i discovered as interesting packages or features which have  distribution dependent support.

| Feature | Noetic (ROS1 LTS) | Humble (ROS2 LTS) | Jazzy (ROS2 LTS) |
|---------|-------------------|-------------------|------------------|
| [slam toolbox](https://github.com/SteveMacenski/slam_toolbox) | Yes | Yes | Yes |
| [gmapping](https://github.com/ros-perception/slam_gmapping?tab=readme-ov-file) | No | No | No |
| KartoSLAM | No | No | No |
| [Hector SLAM](https://wiki.ros.org/hector_slam) | Yes | No | No | 
| [NAV2](https://docs.nav2.org/index.html)    | No | Yes | Yes |
| [Live BT Support](https://docs.nav2.org/tutorials/docs/using_groot.html) | Yes | [No with Nav2](https://docs.nav2.org/migration/Galactic.html#dropping-support-for-live-groot-monitoring-of-nav2) | [No with Nav2](https://docs.nav2.org/migration/Galactic.html#dropping-support-for-live-groot-monitoring-of-nav2) |
| [Explore Lite](https://wiki.ros.org/explore_lite) | Yes | By Source | By Source |
| [FlexBE Behavior Engine](https://github.com/FlexBE/flexbe_behavior_engine) | No | No | Yes |

## Feature Matrix Gazebo

The following table is a list of topis which i discovered as interesting features for the simulation which have  distribution dependent support.

| Feature | Gazebo Classic (V11) | Harmonic (V8) | 
|---------|-------------------|-------------------|
| Mecanum Drive | No | Yes |

## References

<!-- RosCon Presentation about the overall status of ROS1 and ROS 2 in 2023 -->

[The State of ROS: From the Iron Age to the Jazzy Age](https://roscon.ros.org/2023/talks/The_State_of_ROS_From_the_Iron_Age_to_the_Jazzy_Age.pdf)

[Harmonic Feature comparison](https://gazebosim.org/docs/harmonic/comparison)