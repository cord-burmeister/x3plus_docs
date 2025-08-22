# Deployment of ROS components

Deciding whether to create a separate repository for each ROS package depends on several factors, including the size and complexity of your project, the need for modularity, and your development workflow. Here are some considerations to help you decide:

## Benefits of Separate Repositories

**Modularity:** Each package can be developed, tested, and maintained independently, making your project more modular.

**Version Control:** You can version each package separately, which can be helpful for managing dependencies and updates.

**Collaboration:** Separate repositories allow different teams to work on different packages without interfering with each other.

**Deployment:** Easier to deploy and distribute individual packages.

## Benefits of a Monolithic Repository

**Simplicity:** All packages are in one place, making it easier to manage and navigate.

**Consistency:** Easier to maintain consistency across packages, such as coding standards and dependencies.

**Integration:** Easier to integrate and test changes across packages.

Recommendations:

Small Projects: For small projects with only a few packages, a single repository may be simpler and more manageable.

Large Projects: For large projects with many packages or multiple teams working on different components, separate repositories can help with organization and collaboration.

## ROS Distribution and Installation

ROS 2 components are distributed through package repositories and can be installed using package managers like apt on Ubuntu. The distribution includes:

* **ROS 2 Desktop Distribution**: Includes the core components, middleware, tools, and a selection of packages for desktop development.

* **ROS 2 Base Distribution**: Includes only the core components and middleware, suitable for minimal setups.

## Logical distribution

The concept is to structure the packages into 4 logical areas

* **Simulation**: The packages and applications to simulate environment and sensors without the hardware.

* **Remote Core**: Packages which might not able to run on the local robot hardware or for development purposes.

* **Locale Core**: Packages which are required to run on the local robot hardware for autonomous operations.

* **Locale Bot**: Packages which are required to operate local robot hardware.

<!-- ![](images/Ros-Deployment.png) -->