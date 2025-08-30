# Setup the environments

## Setup the ROS 2 workspaces

### Prerequisites

Before running the setup scripts, ensure that you have the following dependencies installed:

- Ubuntu 22.04 or later

### Instructions

1. Clone the repository:

    ```bash
    git clone https://github.com/cord-burmeister/x3plus_setup.git
    cd x3plus_setup
    ```

2. Run the setup script for ROS 2 Humble:

    ```bash
    bash bash/setup-humble.sh
    ```

## Running the Setup Scripts

The `x3plus_setup` project provides several setup scripts to configure different workspaces for the X3Plus robot. Below are the instructions for running each setup script:


### `bash/setup-ws-bot.sh`

This script sets up the workspace for the X3Plus robot controller.

### `bash/setup-ws-gz.sh`

This script sets up the workspace for the X3Plus Gazebo simulation.

### `bash/setup-ws-pit.sh`

This script sets up the workspace for the X3Plus development and cockpit environment.

To run any of these scripts, use the following command:

```bash
bash <script-name>.sh
```

Replace `<script-name>` with the name of the script you want to run.