# Navigation Overview

Indoor robots are evolving with distinct levels of autonomous navigation, as explained by Relay Robotics. This chapter explores how these levels shape robot capabilities and deployment strategies.

## Chapter: Navigating Autonomy — The Relay Robotics Framework

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

## References

[ROS2-Based AMR System for Mapping and Navigation in Unknown Indoor Environments](https://webthesis.biblio.polito.it/33156/1/tesi.pdf): A Master’s Degree Thesis with an overveiw over navigation options

[Autonomous Robot Navigation and Nav2](https://foxglove.dev/blog/autonomous-robot-navigation-and-nav2): Autonomous Robot Navigation and Nav2 overview.

[How Do Robots Find Their Way? A Deep Dive into Navigation Sensors](https://www.technexion.com/resources/how-do-robots-find-their-way-a-deep-dive-into-navigation-sensors/#:~:text=Navigation%20is%20the%20ability%20of,vacuum%2C%20or%20a%20warehouse%20robot): A high level overview over sensor technologies in robot navigation

[Autonomous navigation and mobile robots](https://robotnik.eu/autonomous-navigation-and-mobile-robots/): Overview over the main aspects of robot navigation

[Autonomous Navigation](https://academy.mobile-industrial-robots.com/free-skill-paths/autonomous-navigation/)

[Review Paper: Key Points on Robot Navigation and Its Practical Uses in the Field of Manufacturing](https://www.researchgate.net/publication/380881597_Review_Paper_Key_Points_on_Robot_Navigation_and_Its_Practical_Uses_in_the_Field_of_Manufacturing): Key  aspects  are  covered  in  this review  article,  along  with  a  brief  explanation of mobile  robot  navigation.

[Relay Robotics proposes levels of autonomous navigation for indoor robots](https://www.therobotreport.com/relay-robotics-explains-autonomous-navigation-levels-indoor-robots/): A characterization of the required navigation capabilities for the different abstraction levels.
