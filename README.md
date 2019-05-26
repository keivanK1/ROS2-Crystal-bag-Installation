# ROS2 Crystal Clemmys installation

Installing ROS2 Crystal Clemmys along with ROS bag. You can go through steps or run the `ROS2-Crystal-Install.sh`. If you want base install, comment the `Full install` line and uncomment the `Base install`.

## Requirements

* Linux - Ubuntu 18.04

## Getting Started

* Make sure to set locale to `en_US.UTF-8`:

        sudo locale-gen en_US en_US.UTF-8
        sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
        export LANG=en_US.UTF-8

* Add the repository to your source list:

        sudo apt update && sudo apt install curl gnupg2 lsb-release 
        curl http://repo.ros2.org/repos.key | sudo apt-key add -
        sudo sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'

* Set the ROS distribution name that you want to install, in this case is crystal and install it (choose between full install or base install):

        export CHOOSE_ROS_DISTRO=crystal  # or bouncy or ardent
        sudo apt update
        sudo apt install ros-$CHOOSE_ROS_DISTRO-desktop          # Full install
        #sudo apt install ros-$CHOOSE_ROS_DISTRO-ros-base        # Base install


If you want to use ROS2 bag consider the following steps, otherwise you can skip them and jump to step 4. ROS2 bag is using `ros1_bridge` but it is not included in the ROS2 installation of crystal, so we should first add the related repository to our source list:

    sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
    sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
    sudo apt update
    sudo apt install ros-$CHOOSE_ROS_DISTRO-ros1-bridge 

* The ROS CLI use argcomplition, so install it:

        sudo apt install python3-argcomplete 

* In order to use ROS commands in terminal we need to source the overlay workspace in our `.bashrc`:

        source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash
        echo "source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash" >> ~/.bashrc
        echo "export CHOOSE_ROS_DISTRO=crystal" >> ~/.bashrc

* Install RMW implementation (FastRTPS):

        sudo apt update
        sudo apt install ros-$CHOOSE_ROS_DISTRO-rmw-opensplice-cpp   # for OpenSplice
        sudo apt install ros-$CHOOSE_ROS_DISTRO-rmw-connext-cpp      # for RTI Connext (requires license agreement)

* In this step ROS2 bag will be installed, more information about it can be found [here](https://github.com/ros2/rosbag2).

        export CHOOSE_ROS_DISTRO=crystal # rosbag2 is available starting from crystal
        sudo apt-get install ros-$CHOOSE_ROS_DISTRO-ros2bag* ros-$CHOOSE_ROS_DISTRO-rosbag2* 

* Reboot