#!/bin/sh

screen -dmS dbw bash -c 'cd /home/sean/catkin_ws/ && source devel/setup.bash && roscore'
