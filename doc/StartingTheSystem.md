# Starting the System

### Power

- Switch on the inverter to give power to the monitor
- Turn the car on with the key in the ignition
- Switch on the DataSpeed PDP. There is a "start" button that should do it.
  Otherwise, individually turn on:
  - GPS (RTK)
  - Relay Board
  - GPS
  - Switch
  - Nuc
  - R-eStop
  - Lidar
  - GPS 2
- If the car is charging, then it does not charge the 12v battery under the
  dash, so turn on the external battery charger in the passenger side
  foot-well. Set it to 20A, the third led light should come on. The voltage 
  should start displaying high 13 volts. Note that you may need to press the
  run/stop button to enable.
- Press the power button on the main computer to turn it on

### ROS

There are three separate launch files that need to be run:

1. `host` - covers drive-by-wire system and roscore. **Runs on Nuc**
2. `sensor` - All the sensors. Don't launch if you are playing a ros bag **Runs
   on main computer** 
3. `core` - Runs the web server and all other navigation nodes **Runs on main
   computer**

Connect to the Actor or Actor5 wifi.
Normally, these are run in their own screen session on each computer. To do so:

##### host.launch

```bash
ssh actor@192.168.0.60

# on nuc-host
screen -dmS host roslaunch ltu_actor_vehicle_gem host.launch
```

##### sensor.launch & core.launch

```bash
ssh actor@192.168.0.30

# on actor-main
screen -dmS sensor roslaunch ltu_actor_vehicle_gem sensor.launch
screen -dmS core roslaunch ltu_actor_vehicle_gem core.launch
```

### GPS Base Station

If on LTU's campus, GPS precision can be greatly improved with the use of a RTK
base station. Place the antenna on the fourth most north-east bench, on the
south-east corner of the bench.

### Connect to webpage

<http://192.168.0.30:8020/>

The web page will initially start by showing the default "init" route which just
sends a stop command. Clicking the drop-down shows all the route files stored in
the Vehicle-Gem package. Selecting a new route will automatically load and
begin executing that script. There are four buttons on the screen:
1. **refresh** syncs your browser to the vehicle in case another browser changed
   something. It does not affect the vehicle.
2. **save** saves any edits in your local text-box to the Vehicle-Gem package,
   and restarts the script.
3. **apply** sends any edits in your local text-box to the route server to run,
   but does not save the changed to disk
4. **load** reloads the script from disk in case you have applied changes you do
   not like. It restarts the script to let the reload take effect.

Each time the route is updated, the e-Stop will automatically be triggered.
Click the "Resume" button to clear the e-Stop. This also clears remote or button
eStop events.

### Enabling the Vehicle

Once the route is running and the estop state is "false", the vehicle's
drive-by-wire system must be activated:
- Once per power cycle, the DBW button will blink, meaning the steering wheel
  needs to be calibrated. Center the wheels, then click the button to let it
  know where center is. The DPW button should stop blinking.
- Click the button to toggle between autonomous/manual control. You will feel
  the steering wheel tense up  when in autonomous mode.
- The button should light up red when in autonomous mode. If not, then this is
  an issue with the ROS nodes, saying that the DBW system is not detecting any
  direction commands. If this is the case, the car will need to be restarted.
  
  ### Shutting Down the Vehicle
  
  - Power off the main PC
  - Turn off the vehicle ignition
  - Switch off the inverter
  - Leave the battery charger on in the 20A state
  - Plug in vehicle
