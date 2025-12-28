# Project Structuring

The project shall be structured, so that the logic can run in the simulation as well as on the hardware.

## Runtime structure

The goal here is to be able to swap the hardware layer with the simulation layer by using a defined set of communication topics.

<!--

``` plantuml

@startuml images/repos_structure

title Repository structure

skinparam rectangle {
  BackgroundColor<<Application>> #E6F7FF
  BackgroundColor<<AbstractDDS>> #FDEBD0
  BackgroundColor<<Simulation>> #FADBD8
  BackgroundColor<<Hardware>> #D5F5E3
  BorderColor black
}

rectangle "Cockpit" <<Application>> {
  [x3plus_pit]
}

rectangle "Application Layer" <<Application>> {
  [x3plus]
}

rectangle "Hardware Abstract Layer" <<AbstractDDS>> {
  [ROS topics / interfaces]
}

rectangle "Simulation Layer" <<Simulation>> {
  [x3plus_gz]
}

rectangle "Hardware Layer" <<Hardware>> {
  [x3plus_bot]
  [x3plus_driver]
}

' Connections between layers
[x3plus] -down-> [ROS topics / interfaces]
[x3plus_pit] -down-> [ROS topics / interfaces]

[ROS topics / interfaces] -down-> [x3plus_gz]
[ROS topics / interfaces] -down-> [x3plus_bot]
[x3plus_bot] -down-> [x3plus_driver]

@enduml 
```
-->

![repos_structure](images/repos_structure.png)

## Implementation status

This is a list of topics which will be supported in the mapping.

!!! note "WIP"
    This mapping is work in progress

| Description | Gazebo | Hardware | Topic | Direction |
| ----------- | ------ | -------- | ----- | --------- |
| Drive Commands | ![task](images/task.png) | ![task](images/task.png) | /cmd_vel | In |
| Odometry | ![ok](images/ok.png) | ![task](images/task.png) | /wheeled/odom | Out |
| Battery Voltage | ![To Do](images/task.png) | ![ok](images/ok.png) | /voltage | Out |
| Imu | ![ok](images/ok.png) | ![ok](images/ok.png) | /imu/data_raw | Out |
| LIDAR | ![ok](images/ok.png) | ![ok](images/ok.png) | /scan_raw | Out |

<!-- 
| Velocity | ![To Do](images/notok.png) | ![ok](images/ok.png) | /vel_raw | Out |
| Edition | ![v](images/notok.png) | ![ok](images/ok.png) | /edition | Out |
| Buzzer | ![To Do](images/notok.png) | ![ok](images/ok.png) | /Buzzer | In |
| MagneticField | ![To Do](images/notok.png) | ![ok](images/ok.png) | /imu/mag | Out | 
-->

![ok](images/ok.png) Topic is integrated

![task](images/task.png) This has to be done and documented for the final integration

![To Do](images/notok.png) Topic can be ignored
