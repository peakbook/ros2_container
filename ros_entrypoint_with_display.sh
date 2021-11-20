#!/bin/bash
set -e

# setup ros2 environment
source "/opt/ros/$ROS_DISTRO/setup.bash"

# launch background programs
/usr/bin/supervisord

exec "$@"
