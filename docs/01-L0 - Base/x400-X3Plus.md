# Describe the robot

## ROSMASTER X3 PLUS

ROSMASTER X3 PLUS is an omnidirectional movement robot developed based on the ROS robot operating system. It supports four controllers: Jetson NANO 4GB/ORIN NX/ORIN NANO and Raspberry Pi 5. It is equipped with high-performance hardware configurations such as lidar, depth camera, 6DOF robotic arm, 520 high-power motor, voice recognition interactive module, and HD 7-inch display screen. It can realize applications such as APP mapping and navigation, automatic driving, human feature recognition, moveIt robotic arm simulation control and multi-machine synchronous control. It supports mobile phones, handles, computer keyboards remote control. 124 video tutorials with Chinese and English subtitles and codes are provided for free.

Reasonable design, unique shape

* X3PLUS supports four development boards: Jetson NANO 4GB/ORIN NX/ORIN NANO/RaspberryPi 5, suitable for different users.
* The whole robot is made of green aluminum alloy material, which is safe and non-toxic, beautiful and durable.
* Mecanum wheel and pendulum suspension chassis can make the robot adapt to uneven ground.

![](images/Rosmaster-X3Plus.jpg)

## Vision for a variant

The goal is to modify the original design to a simpler structure. Lets replace the arm with a pan tilt unit to have a flexible visualization unit.

![X3Plus-Explorer](images/X3Plus-Explorer.png)

## Logical Structure

The robot has a logical structure, which we should plan for.

<!--

``` plantuml
@startuml images/x3plus_structure
skinparam componentStyle rectangle

[Base footprint] as base_footprint
[Base link] as base_link
[back_left_wheel] as back_left_wheel
[back_right_wheel] as back_right_wheel
[front_left_wheel] as front_left_wheel
[front_right_wheel] as front_right_wheel
[imu_link] as imu_link
[camera_link] as camera_link
[laser_link] as laser_link

[pan_link] as pan_link
[tilt_link] as tilt_link


[pendulum_link] as pendulum_link

base_footprint ..> base_link : base_joint (fixed)

base_link -down-> pendulum_link : pendulum_joint (revolte)
pendulum_link -down-> front_left_wheel : front_left_joint (revolte) 
pendulum_link -down-> front_right_wheel : front_right_joint (revolte)
base_link -down-> back_left_wheel : back_left_joint (revolte)
base_link -down-> back_right_wheel : back_right_joint (revolte)

base_link ..>  imu_link : imu_joint (fixed)
base_link ..>  laser_link : laser_joint (fixed)

base_link -down-> pan_link : pan_joint (revolte)
pan_link -down-> tilt_link : tilt_joint (revolte)
tilt_link ..>  camera_link : camera_joint (fixed)

@enduml
```

-->

![](images/x3plus_structure.png)

## References

[ROSMASTER X3 PLUS on Github](https://github.com/YahboomTechnology/ROSMASTERX3-PLUS)

[Building a Pan-Tilt Mechanism](https://kamathsblog.com/building-a-pan-tilt-mechanism)