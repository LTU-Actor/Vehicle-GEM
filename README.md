# Vehicle-GEM

Vehicle platform for Polaris GEM e2 with a drive-by-wire kit made by Dataspeed. Also retrofitted with a primary computer, Intel NUC, Raspberry Pi, Ardunio Uno, and many sensors.

## Requirements

The Arduino connected to the gear shifter and can bus must be flashed using the dbw_can_bus.ino file.

## Starting DBW System On Start Up

Add a symbolic link to the dbw.sh file to automatically start the drive-by-wire system on roshost startup.
```
ln -s /scripts/dbw.sh /etc/init.d/
```

## Add IPs Addresses Aliases
```
./scripts/update-hosts
```

## Update Ros IP and Master URI
```
./scripts/ros-env-loader
```

## Launching On The Intel NUC
```
<include file="$(find ltu_actor_vehicle_gem)/launch/host.launch">
```

## Launching On The Primary Computer
```
<include file="$(find ltu_actor_vehicle_gem)/launch/core.launch">
<include file="$(find ltu_actor_vehicle_gem)/launch/sensor.launch">
```

**Note:** The Intel NUC is used as the ros master. 
