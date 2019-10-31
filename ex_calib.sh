#! /bin/bash

# Kill in turtle
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 bash'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 bringup.sh'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 python'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 hlds_laser_publisher'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 turtlebot3_diagnostics'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 sshd'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 raspi_camera.sh'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 roslaunch'
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'killall -9 raspicam_node'

# Kill in LAPTOP
killall -9 ssh
killall -9 roslaunch
killall -9 rosout
killall -9 rosmaster

#source files
source /opt/ros/kinetic/setup.bash
source ~/catkin_ws/devel/setup.bash

roscore &

sleep 5

#raspi_camera
sshpass -p "123456" ssh -o StrictHostKeyChecking=no robot@192.168.1.9 'source /opt/ros/kinetic/setup.bash && export ROS_MASTER_URI=http://192.168.1.3:11311 && export ROS_HOSTNAME=192.168.1.9 && source ~/catkin_ws/devel/setup.bash && roslaunch turtlebot3_autorace_camera turtlebot3_autorace_camera_pi.launch' &

sleep 10

export AUTO_IN_CALIB=action
export GAZEBO_MODE=false
roslaunch turtlebot3_autorace_camera turtlebot3_autorace_intrinsic_camera_calibration.launch &

sleep 10

export AUTO_EX_CALIB=calibration
export GAZEBO_MODE=false
roslaunch turtlebot3_autorace_camera turtlebot3_autorace_extrinsic_camera_calibration.launch &

sleep 10

rqt &

sleep 5

rosrun rqt_reconfigure rqt_reconfigure &

sleep 5



