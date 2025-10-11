# Levels of Autonomy for Robots

## Introduction

 Stakeholders in a large variety of industries are considering autonomous robots. However, we are still some time away from achieving reliable and robust long-term autonomy in the real world. Fortunately, even at the current levels of autonomy, robots can be deployed to help with a variety of tasks and deliver significant benefit to end-users across industries.

## Levels of Autonomy

 Thinking of autonomy as a long-term objective with a levels-based framework will help achieve realistic real-world deployments. Increasing levels of autonomy should be designed to increasingly simplify human user experience. Starting from the human having to control almost all aspects of the robotic system (Level 0), all the way to the team of robots carrying out specific tasks in dynamic and unstructured environments adapting and learning beyond what the designer or the user programmed (Level 5).

| Level |Description | Time between Interventions |
|-------|------------|----------------------------|
| 0     | Full manual teleoperation | n/a |
| 1     | Robot within line of sight (hands off) | 5 minutes |
| 2     | Operator on site or nearby (eyes off) | 1 hour |
| 3     | One operator oversees many robots (mind off) | 8 hours |
| 4     | Supervisor not on site (monitoring off) | 3 days |
| 5     | Robots adapt and improve execution (development off) | extended operation |

The levels of autonomy are designed to describe how autonomous a robot is in executing a task. They tie back to the attention a human supervisor has to provide the robot or a team of robots while they are executing the task.

### Level 1 Autonomy (hands off)

A human needs to be always within line of sight of the robot. For example, in the agricultural automation system shown in the picture below, a human must always follow a robot as it goes through the field. Simple reactive tasks such as keeping the robot in the center of the row or spraying when a weed is detected are automated. A widely deployed example of autonomous systems at this level of autonomy are GPS guided tractors. Here, the human is required to be in the cab to take care of unforeseen events, but the tractor drives itself on pre-programmed paths.

### Level 2 Autonomy (eyes off)

Now, the human operators switch to being (remote) supervisors: They don’t have to follow the robot, the robot may be out of line of sight, but the human still must remain on the field and keep monitoring the robot in case it needs rescuing. This capability is an enabling-point for high-value applications in many industries. For example at Level 2, an agricultural robot might be able to navigate a way-point prescribed path avoiding most obstacles, and only get stumped once in a while. The target time between interventions increases to about an hour. At this level of autonomy, the human may be able to do other tasks on the field, but likely only have one or two robots running autonomously under their supervision.

### Level 3 Autonomy (mind off)

In many industries, Level 3 autonomy represents an inflection point where large-scale deployments become quite attractive. A Level 3 robotic team is sufficiently capable of dealing with edge cases for several days so that a single human can monitor a number of robots. This is where most multi-robot based farming systems begin to scale up. The human still might need to be on the field though to swap batteries, perform repairs, or rescue a stranded robot every so often.

### Level 4 Autonomy (monitoring off)

At level 4, autonomous robots can really be deployed at large scale, without being constrained by labor costs. Level 4 autonomous robot teams are capable of dealing with many of the edge cases themselves, becoming sufficiently autonomous so that the human doesn’t feel the need to be on the field. They also have sufficient automated support infrastructure on-site. The robots are capable of finding their base stations, get a new battery, perform minor repairs, and get out of difficult cases (perhaps with help from a remote human). This level of autonomy needs not only the on robot software to mature, but the on-field infrastructure to automate and typically a reliable connection with remote users.

### Level 5 Autonomy (development off)

At level 5, the robots begin to learn from  their experience to improve operation beyond what the human designer has programmed in. They learn from each other, on site and from robot teams from other sites. They learn to predict how events affect their capabilities and plan proactively.

As an example of how human interaction with the system changes with increasing levels of autonomy, consider the following with the multi-robot agricultural autonomy example: At Level 3, the human on the field is responsible for organizing field activity if it is going to rain. At Level 4, the robot team uses data from the internet to determine when to go out based on the weather. At level 5, the robot team, anticipating its going to rain tomorrow, learns to take care of tasks on the day before!

## References

[Levels of Autonomy for Field Robots](https://www.earthsense.co/news/2020/7/24/levels-of-autonomy-for-field-robots)

[SAE Levels of Driving Automation™ Refined for Clarity and International Audience](https://www.sae.org/blog/sae-j3016-update)

[The 6 Levels of Vehicle Autonomy Explained](https://www.synopsys.com/blogs/chip-design/autonomous-driving-levels.html)
