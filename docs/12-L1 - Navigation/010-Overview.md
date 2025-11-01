# Navigation Overview

Indoor robots are evolving with distinct levels of autonomous navigation, as explained by Relay Robotics. This chapter explores how these levels shape robot capabilities and deployment strategies.

## Aspects for navigation

### Installation complexity

In general, indoor robots today go through an installation process before being put into operation. In addition to modifying building infrastructure, mapping, labeling, and other required setup can be a part of this process. This can often be cost-, time-, and labor-intensive.

### Social navigation

Indoor environments are highly social spaces. Robots have to co-navigate with all other agents, human and robot, that are also using the space.

Successfully navigating in these highly unstructured and social environments requires skills and behaviors that are usually placed under the label “social navigation.”

### Operational domain helps define autonomous navigation

A robot’s operational domain is the kinds of environments it can be successful in. Not all indoor environments are the same. Different environments have different needs and might require different levels of navigation sophistication.

### Multi-floor autonomous navigation

elf-driving cars need only worry about single-level roads. But a large number of buildings in the world are multi-floor, and robots need to be able to traverse those floors to be effective.

## Navigating Autonomy — The Relay Robotics Framework

In the bustling corridors of modern hotels, hospitals, and office buildings, indoor service robots are becoming a familiar sight. But behind their smooth movements lies a complex hierarchy of autonomy. Relay Robotics, a pioneer in indoor delivery robots, has introduced a structured framework to define *five levels of autonomous navigation*, offering clarity in a rapidly advancing field.

### Level 0: Remote Control

At the base of the autonomy pyramid is **Level 0**, where robots are manually operated by humans. This mode is akin to remote-controlled toys—useful for testing or training, but not scalable for real-world deployment.

### Level 1: Predefined paths

Robots that have a minimal sensor suite and can only navigate on paths that are predefined using physical mechanisms like wires buried in the floor, magnetic tape or paint. These Level 1 robots have no ability to leave these predefined paths.

### Level 2: Infrastructure Assisted Navigation

Here, robots can follow basic paths but still rely heavily on infrastructure input. They might use line-following or beacon-based systems, which limit flexibility and require pre-installed infrastructure.

### Level 3: Autonomous with Predefined Maps

This level marks a significant leap. Robots can navigate using **preloaded maps**, avoiding obstacles and following routes without human intervention. However, they struggle with dynamic environments or unexpected changes.

### Level 4: Dynamic Autonomy

Robots at this stage can **build and update maps in real time**, adapting to shifting layouts and moving objects. They use advanced sensors and SLAM (Simultaneous Localization and Mapping) to operate independently in complex indoor spaces.

### Level 5: Full Autonomy with Semantic Understanding

The pinnacle of indoor navigation, Level 5 robots not only navigate but also understand their environment. They interpret signs, recognize rooms, and make decisions based on context—like rerouting if a hallway is blocked or choosing the best elevator.

### Summary

Relay Robotics emphasizes that most commercial indoor robots today operate at **Level 3 or 4**, balancing reliability with adaptability. Achieving Level 5 remains a frontier, requiring breakthroughs in AI, perception, and semantic reasoning.

This framework helps businesses assess robot capabilities and choose the right level for their needs. Whether delivering towels in a hotel or transporting lab samples in a hospital, understanding these levels ensures smoother integration and better performance.

| Level | Installation Complexity | Social Navigation     | Operational Domain     | Multi-Floor Navigation     |
|-------|--------------------------|------------------------|-------------------------|-----------------------------|
| 1  | ![red](images/circle-red.png) ![red](images/circle-red.png) ![red](images/circle-red.png) ![red](images/circle-red.png)  | ![blue](images/circle-blue.png) | ![purple](images/circle-purple.png) | Rarely Compatible |
| 2  | ![red](images/circle-red.png) ![red](images/circle-red.png) ![red](images/circle-red.png) | ![blue](images/circle-blue.png) | ![purple](images/circle-purple.png) ![purple](images/circle-purple.png) | Sometimes Compatible |
| 3  | ![red](images/circle-red.png) | ![blue](images/circle-blue.png) ![blue](images/circle-blue.png) | ![purple](images/circle-purple.png) ![purple](images/circle-purple.png) ![purple](images/circle-purple.png) | Compatible |
| 4  | ![red](images/circle-red.png) | ![blue](images/circle-blue.png) ![blue](images/circle-blue.png) ![blue](images/circle-blue.png) ![blue](images/circle-blue.png) | ![purple](images/circle-purple.png) ![purple](images/circle-purple.png) ![purple](images/circle-purple.png) ![purple](images/circle-purple.png) | Expected |
| 5  | | ![blue](images/circle-blue.png) ![blue](images/circle-blue.png) ![blue](images/circle-blue.png) ![blue](images/circle-blue.png) | ![purple](images/circle-purple.png) ![purple](images/circle-purple.png) ![purple](images/circle-purple.png) ![purple](images/circle-purple.png) | Expected |

## References

[ROS2-Based AMR System for Mapping and Navigation in Unknown Indoor Environments](https://webthesis.biblio.polito.it/33156/1/tesi.pdf): A Master’s Degree Thesis with an overview over navigation options

[Autonomous Robot Navigation and Nav2](https://foxglove.dev/blog/autonomous-robot-navigation-and-nav2): Autonomous Robot Navigation and Nav2 overview.

[How Do Robots Find Their Way? A Deep Dive into Navigation Sensors](https://www.technexion.com/resources/how-do-robots-find-their-way-a-deep-dive-into-navigation-sensors/#:~:text=Navigation%20is%20the%20ability%20of,vacuum%2C%20or%20a%20warehouse%20robot): A high level overview over sensor technologies in robot navigation

[Autonomous navigation and mobile robots](https://robotnik.eu/autonomous-navigation-and-mobile-robots/): Overview over the main aspects of robot navigation

[Autonomous Navigation](https://academy.mobile-industrial-robots.com/free-skill-paths/autonomous-navigation/)

[Review Paper: Key Points on Robot Navigation and Its Practical Uses in the Field of Manufacturing](https://www.researchgate.net/publication/380881597_Review_Paper_Key_Points_on_Robot_Navigation_and_Its_Practical_Uses_in_the_Field_of_Manufacturing): Key  aspects  are  covered  in  this review  article,  along  with  a  brief  explanation of mobile  robot  navigation.

[Relay Robotics proposes levels of autonomous navigation for indoor robots](https://www.therobotreport.com/relay-robotics-explains-autonomous-navigation-levels-indoor-robots/): A characterization of the required navigation capabilities for the different abstraction levels.

[Principles and Guidelines for Evaluating Social Robot Navigation Algorithms](https://arxiv.org/abs/2306.16740): Overview Social Robot Navigation Algorithms
