#!/bin/bash

sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 bash'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 bringup.sh'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 python'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 hlds_laser_publisher'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 turtlebot3_diagnostics'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 sshd'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 raspi_camera.sh'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 roslaunch'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 raspicam_node'

#Kill in LAPTOP
killall -9 ssh
killall -9 roslaunch
killall -9 rosout
killall -9 rosmaster

#source files
source /opt/ros/kinetic/setup.bash
source ~/catkin_ws/devel/setup.bash

#rosmaster
roscore &

sleep 5

#raspi_camera
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'source /opt/ros/kinetic/setup.bash && export ROS_MASTER_URI=http://192.168.1.3:11311 && export ROS_HOSTNAME=192.168.1.9 && source ~/catkin_ws/devel/setup.bash && roslaunch turtlebot3_autorace_camera turtlebot3_autorace_camera_pi.launch' &

sleep 10

#instrinsic_camera
export AUTO_IN_CALIB=action
export GAZEBO_MODE=false
roslaunch turtlebot3_autorace_camera turtlebot3_autorace_intrinsic_camera_calibration.launch &

sleep 10

#extrinsic_camera
export AUTO_EX_CALIB=action
export GAZEBO_MODE=false
roslaunch turtlebot3_autorace_camera turtlebot3_autorace_extrinsic_camera_calibration.launch &

sleep 10
 
#detect lane
export AUTO_DT_CALIB=action
roslaunch turtlebot3_autorace_detect turtlebot3_autorace_detect_lane.launch &

sleep 10

#control_lane
roslaunch turtlebot3_autorace_control turtlebot3_autorace_control_lane.launch &

sleep 5

#run!!!
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'source /opt/ros/kinetic/setup.bash && export ROS_MASTER_URI=http://192.168.1.3:11311 && export ROS_HOSTNAME=192.168.1.9 && source ~/catkin_ws/devel/setup.bash && roslaunch turtlebot3_bringup turtlebot3_robot.launch' &

sleep 10

#image
rqt_image_view &

sleep 5
