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

The `x3plus_setup` project provides several setup scripts to configure different workspaces for the X3Plus robot.

### `bash/setup-ws-bot.sh`

This script sets up the folder with the controller driver and the workspace for the X3Plus robot controller.

```bash
bash setup-ws-bot.sh
```

!!! note "This takes a while"
    The script is downloading the source code, reloads the dependencies which might take a while

## Install the driver for the controller

. Open the terminal and navigate to the folder containing the file:

``` bash
cd ~/x3plus_driver/py_install
```

Run the installation command. This will overwrite any previously installed Rosmaster_Lib:

```bash
sudo python3 setup.py install
```

<!-- Copying Rosmaster_Lib-3.3.9-py3.10.egg to /usr/local/lib/python3.10/dist-packages
Adding Rosmaster-Lib 3.3.9 to easy-install.pth file

Installed /usr/local/lib/python3.10/dist-packages/Rosmaster_Lib-3.3.9-py3.10.egg
Processing dependencies for Rosmaster-Lib==3.3.9
Finished processing dependencies for Rosmaster-Lib==3.3.9 -->

!!! note "Hardware installation is required"
    Do not forget to install the Yahboom ROS robot control board with STM32F103RCT6 IMU with the configuration of the USB binding

## Compile the workspace

The workspace is prepared and can now be compiled.

```bash
colcon build
```

## References

[Startup Guide to Yahboom ROS Robot Control Board](https://my.cytron.io/tutorial/startup-guide-to-yahboom-ros-robot-control-board)
