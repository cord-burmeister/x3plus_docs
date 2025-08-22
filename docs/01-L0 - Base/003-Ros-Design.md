# ROS Concepts and Design Patterns

## Overview

Robot Operating System (ROS) 2 is a significant evolution from ROS 1, aiming to improve what wasn’t optimal in the original framework. Let’s delve into some key design aspects:

Prescribed Patterns for Building Systems:

1. While maintaining ROS’s flexibility, ROS 2 introduces clear patterns and supporting tools for features like life cycle management and static configurations for deployment1.
These patterns help developers structure their systems effectively.
2. Middleware Choice: DDS (Data Distribution Service):
ROS 2 uses DDS as its middleware, which facilitates communication between nodes.
DDS offers pros (scalability, reliability) and cons (complexity, learning curve), but it’s a robust choice for ROS 22.
3. Remote Procedure Call (RPC) Interfaces:
ROS 2 explores design patterns for RPC interfaces.
The focus is on specifying the user API, leaving the implementation details open (e.g., Apache Thrift, ROS RPC, or MsgPack).
In summary, ROS 2 emphasizes clarity, patterns, and improved middleware, making it a powerful platform for robotics development

## Concept

 Let’s envision the construction of a wheeled robot that chases a red ball using Robot Operating System (ROS). Here’s how we might structure the system:

1. Camera Node:
The robot has a camera sensor to capture images of the environment.
A ROS node processes these camera images.
2. Vision System Node:
Another ROS node analyzes the camera images to locate the red ball.
It computes the ball’s position relative to the robot.
3. Control System Node:
The control system node receives information about the ball’s position.
Based on this data, it determines the direction in which the robot should move.
4. Motor Control Node:
Finally, a ROS node controls the robot’s motors (wheels).
It translates the desired movement direction into motor commands.
By orchestrating these nodes, our ROS-based robot can effectively chase the red ball

![ros_graph_example](images/ros_graph_example.png)

Let’s explore the design of a ROS-based system that separates software into four distinct nodes. These nodes communicate via three ROS topics, forming what we call a ROS communication graph. Here’s how it works:

1. Camera Driver Node:
    * The camera driver node handles interactions with the physical camera.
    * It encapsulates details like custom USB protocols or vendor-provided libraries.
    * The node presents a standard topic interface to the system.
2. Blob Finder Node:
    * This node doesn’t need to know camera specifics.
    * It receives image data in a standard format (used for all ROS cameras).
    * The output is the detected location of the red ball (also in a standard format).
3. Target Follower Node:
    * Receives the ball location information.
    * Computes the steering direction needed to move toward the ball (again, in a standard format).
4. Motor Driver Node:
    * Converts the desired steering direction into specific instructions for the robot’s wheel motors.

By examining this communication graph, we gain insights into the system’s structure and functionality

Let’s delve into the terminology associated with the ball-chasing robot example and explore how the ROS communication graph operates:

## Publish-Subscribe Messaging (Pub-Sub):

The ROS communication graph follows a well-known pattern called pub-sub.

1. In pub-sub systems, data is sent as messages from publishers to subscribers.
    * A publisher can have zero, one, or multiple subscribers listening to its published messages.
    * Messages can be published at any time, making the system asynchronous.
2. ROS Topics and Nodes:
    * In ROS, nodes communicate via topics, each with a name and a type.
    * A publisher advertises a topic to announce that it will publish data. For instance, the camera driver node might advertise a topic named /image with type sensor_msgs/Image.
    * If the blob finder node subscribes to a topic with the same name and type, the nodes establish a connection.
    * Messages flowing across the /image topic will be of type sensor_msgs/Image.
3. Node Roles:
    * A single node can act as both a publisher and a subscriber.
In our example, the blob finder subscribes to image messages and publishes ball location messages.
    * Similarly, the target follower subscribes to ball location messages and publishes steering direction messages.
4. Importance of Message Types:
    * ROS types are crucial for syntax and semantics.
    * A type specifies the fields and their meanings in a message. For example, a thermometer and a pressure sensor might produce similar data (floating-point values).
    * However, well-designed ROS nodes use semantically meaningful message types (e.g., sensor_msgs/Temperature or sensor_msgs/FluidPressure).

Remember to choose message types that align with your application’s semantics when building real systems

## References

[ROS Concepts and Design Patterns](https://osrf.github.io/ros2multirobotbook/ros2_design_patterns.html)

[Introduction to ROS2 and Robotics](https://www.learnros2.com/)
