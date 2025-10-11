
# Adding keyboard  teleoperations

One of the first possibilities to control a definitions of a robot is to operate it remotely with a teleoperation. There is a package which converts console input into twist messages. Note that the command with the default topic will be mapped to the robot topic.

``` bash
ros2 run  teleop_twist_keyboard teleop_twist_keyboard 
```
