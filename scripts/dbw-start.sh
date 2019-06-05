#!/bin/sh

screen -dmS dbw bash -c 'cd /home/actor/LTU-Actor/ && source devel_isolated/setup.bash && roslaunch ltu_actor_vehicle_gem host.launch'
