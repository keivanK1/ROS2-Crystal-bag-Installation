#!/bin/bash

# Make sure to set locale to `en_US.UTF-8`:
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# Add the repository to your source list:
sudo apt update && sudo apt install curl gnupg2 lsb-release -y
curl http://repo.ros2.org/repos.key | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'

# Set the ROS distribution name that you want to install, in this case is crystal and install it (choose between full install or base install):
export CHOOSE_ROS_DISTRO=crystal  # or bouncy or ardent
sudo apt update
# If you want just Base installation (without GUI) uncomment it
sudo apt install ros-$CHOOSE_ROS_DISTRO-desktop -y              # Full install
#sudo apt install ros-$CHOOSE_ROS_DISTRO-ros-base -y            # Base install

# Installing ros1_bridge
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt update
sudo apt install ros-$CHOOSE_ROS_DISTRO-ros1-bridge -y

# The ROS CLI use argcomplition, so install it:
sudo apt install python3-argcomplete -y

# In order to use ROS commands in terminal we need to source the overlay workspace in our `.bashrc`:
source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash
echo "source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash" >> ~/.bashrc

# Install RMW implementation (FastRTPS):
sudo apt update
sudo apt install ros-$CHOOSE_ROS_DISTRO-rmw-opensplice-cpp -y       # for OpenSplice
sudo apt install ros-$CHOOSE_ROS_DISTRO-rmw-connext-cpp -y          # for RTI Connext (requires license agreement)

# In this step ROS2 bag will be installed, more information about it can be found [here](https://github.com/ros2/rosbag2).
export CHOOSE_ROS_DISTRO=crystal # rosbag2 is available starting from crystal
sudo apt-get install ros-$CHOOSE_ROS_DISTRO-ros2bag* ros-$CHOOSE_ROS_DISTRO-rosbag2* -y

# Installing build system for ROS2 (Colcon):
sudo apt install python3-colcon-common-extensions -y