#! /bin/bash

#kill in TB3
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 bash'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 bringup.sh'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 python'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 hlds_laser_publisher'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 turtlebot3_diagnostics'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 sshd'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 raspi_camera.sh'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 roslaunch'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 raspicam_node'

#kill in LAPTOP
killall -9 ssh
killall -9 roslaunch
killall -9 rosout
killall -9 rosmaster

echo "tunning Completed!!!"
