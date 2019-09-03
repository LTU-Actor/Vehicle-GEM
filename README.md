# Vehicle-GEM

**This is the "root" package for the Actor system**. It contains the core launchfiles and route scripts to launch and operate the system on the GEM platform.

Vehicle platform for Polaris GEM e2 with a drive-by-wire kit made by Dataspeed. Also retrofitted with a primary computer, Intel NUC, Raspberry Pi, Ardunio Uno, and many sensors.

# Requirements

- The Arduino connected to the gear shifter and can bus must be flashed using the `dbw_can_bus.ino` file.
- Compile all the actor packages in a workspace and add  `source /path/to/devel/setup.bash` to your `.bashrc`.

# Run the system

####  Add IPs Addresses Aliases

On each PC you need to run actor packages, run the `update-hosts` script. This will ensure the /etc/hosts file has the required lines in it.

```sh
rosrun ltu_actor_vehicle_gem update-hosts # roscore not needed to be running
```

## Update Ros IP and Master URI

To ensure that the `ROS_IP` and `ROS_MASTER_URI` are set for each shell session, add the following to your `.bashrc`.

```sh
rosrun ltu_actor_vehicle_gem ros-env-loader
```

## Launching the root launch files

The Actor system is split into three separate top-level launch files:

1. host:
   This should launch first on the pc that will run roscore. It runs the estop, raspberry pi communication, and vehicle communication layer.

2. sensor:
   This launches the nodes to read from all vehicle sensors. If running the system from a rosbag, then do not launch this file.

3. core:
   This launches the meat of the system, including the web interface. It it intended to be run on the bigger computer and communicate with roshost over ethernet.


All three packages are intended to be launched manually each time the system is started.

### Launching on the host NUC
```sh
screen -dmS host 'roslaunch ltu_actor_vehicle_gem host.launch'
```

### Launching on the primary compute computer
```xml
screen -dmS core 'roslaunch ltu_actor_vehicle_gem core.launch'
screen -dmS sensor 'roslaunch ltu_actor_vehicle_gem sensor.launch'
```

# Next Steps

From here, look for the README documentation for the `Core` package.
