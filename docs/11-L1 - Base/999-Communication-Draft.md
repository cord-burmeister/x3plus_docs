# Communication

Designing message frequency and Quality of Service (QoS) in a ROS 2 project involves balancing the needs of different nodes (e.g., latency for control vs. reliability for logging) while considering system constraints.

Here is a structured approach for designing both frequency and QoS parameters.

## Part 1: Designing Message Frequency

Message frequency (the publish rate) is determined by the specific requirements of the sensor or control loop.

| Node Type | Frequency Guidance | Example Topics |
| --------- | ------------------ | -------------- |
| Low-Level Control | High & Consistent (100 Hz+) | /cmd_vel, /odom, /joint_states |
| Mapping Localization | Moderate (10–30 Hz) | /scan, /camera/image_raw |
| High-Level Planning | Low/Event-Driven (1–5 Hz) | /global_plan, /goal_pose |
| Configuration/Logging | Very Low/On-Demand (<< 1 Hz) | /rosout, /parameter_events |

Key Considerations:

* Sensor Specifications: Use the maximum rate provided by your hardware datasheet.
* Required Latency: Control loops generally need lower latency (higher frequency) to react quickly to changes.
* Computational Cost: Publishing a heavy topic (like a 4K camera image) at 30 Hz might overload your CPU/network. Find a balance between data currency and system performance.
* Data Volume: If data is mostly static (e.g., a map update), you only need infrequent updates.

## Part 2: Designing the QoS Profile

The ROS2 QoS is primarily designed for robotic and real-time systems where inter-process communication takes place mainly in a local network. As such the ROS2 DDS is optimized for low-latency and high reliability.

Quality of Service (QoS) parameters define how the ROS 2 system should handle the data exchange, focusing on reliability, persistence, and latency.

The main parameters you'll use are reliability and durability.

* **Reliability** policy has two options: the **RELIABLE** mode which guarantees message delivery and the **BEST_EFFORT** mode which focuses on speed and overhead reduction in high frequency messaging where losses are tolerable.
* **Durability** policy mitigates message persistence for late-joining subscribers. The **VOLATILE** mode discards received messages and late subscribers will not receive them, leading to memory efficiency; while **TRANSIENT_LOCAL** preserves the most recent messages for late-joining subscribers which is vital in applications where initialization or state data reading is important.
* **History** policy regulate the message queue size: the **KEEP_LAST** option retains only the most recent messages where is the depth parameter. The **KEEP_ALL** option preserves all messages for indefinite time until they are consumed, thus it requires significantly more memory.

## Standard QoS Profiles in ROS 2

ROS 2 provides built-in profiles that cover 90% of use cases:

* **SENSOR_DATA Profile:** Generally preferred for standard robot operation.

  * Reliability: Best Effort (prioritizes speed over guaranteed delivery; drops a scan if a new one is ready).
  * Durability: Volatile (subscribers only receive data while connected).

* **SYSTEM_DEFAULT / ROS_DEFAULT_QOS Profile:**

  * Reliability: Reliable (guarantees every message arrives, resends if lost).
  * Durability: Volatile (subscribers only receive data while connected).
* **TRANSIENT_LOCAL Durability Profile:**

  * Reliability: Reliable
  * Durability: Transient Local (stores the last published message so new subscribers immediately receive the most recent data).

## How to Choose Your QoS Profile

Use this table as a guide for common topics:

| Topic Example | Frequency | Preferred QoS Profile | Rationale |
| ------------- | --------- | --------------------- | --------- |
| /scan, /camera/image | High | SENSOR_DATA | Speed matters more than missing an occasional frame. |
| /odom, /cmd_vel | High | SENSOR_DATA | Latency is critical for real-time control loops. |
| /map, /robot_description | Low | TRANSIENT_LOCAL | New nodes need the map/URDF immediately upon startup. |
| /parameter_events | Low | SYSTEM_DEFAULT | Need guaranteed delivery of configuration changes. |

Implementation in Code/YAML

You set these parameters when you create publishers or subscribers in your code. The most common way is using the rclpy.qos module in Python or rclcpp::QoS in C++.

## Example in Python (rclpy)

``` python
import rclpy
from rclpy.qos import QoSProfile, ReliabilityPolicy, DurabilityPolicy

def create_sensor_publisher(node):
    # This profile matches the standard SENSOR_DATA profile
    qos_profile = QoSProfile(
        depth=10,
        reliability=ReliabilityPolicy.BEST_EFFORT,
        durability=DurabilityPolicy.VOLATILE
    )
    node.create_publisher(
        SomeMessageType,
        '/topic_name',
        qos_profile
    )
```

By aligning the frequencies with functional requirements and matching your QoS profiles between publishers and subscribers, you ensure robust and efficient communication within your ROS 2 system.

## RViz2 and QoS Profiles

In RViz 2, the QoS profile you need to select for a specific display must match the QoS profile used by the publisher of that topic.

!!! warning "RViz2 and QoS Profiles"
    RViz 2 acts as a subscriber to all the topics you display (e.g., /scan, /odom, /camera/image_raw). If the publisher and the subscriber do not have compatible QoS settings (especially Reliability and Durability), RViz will not receive the data, and your display will appear blank or show a "No message received" warning.

### General Guidelines for RViz 2 Configuration

You don't typically "design" the QoS for RViz 2; you simply configure RViz 2 to match what your robot is already publishing.

### How to Manually Adjust QoS in RViz 2

If you add a display in RViz 2 and don't see any data, you probably have a QoS mismatch. You need to manually adjust the settings:
Select the specific display in the "Displays" panel (e.g., the "Map" display).
Expand the "QoS" property group within that display's settings.
Modify the Durability and Reliability dropdown menus to match what the corresponding node in your robot system is publishing.
The most common scenario requiring manual changes in RViz 2 is when displaying static data like Maps or Robot Descriptions, where you must switch the Durability to Transient Local.

## References

[Quality of Service settings](https://docs.ros.org/en/kilted/Concepts/Intermediate/About-Quality-of-Service-Settings.html): ROS 2 offers a rich variety of Quality of Service (QoS) policies that allow you to tune communication between nodes.

[A soft real-time ROS2-based energy management system under asynchronous messaging and different node update rates](https://www.sciencedirect.com/science/article/pii/S2590174525004040#:~:text=In%20this%20respect%2C%20QoS%20policies%20can%20affect,history%2C%20depth%2C%20lifespan%2C%20deadline%20and%20liveliness%20%5B70%5D.): Several case studies performed in a critical and objective manner allow us to calibrate, test and compare existing off-the-shelf numerical optimizers, in terms of advantages and disadvantages.
