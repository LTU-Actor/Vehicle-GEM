#! /bin/bash

### BEGIN INIT INFO
# Provides:          dbw
# Required-Start:    $local_fs $network
# Required-Stop:     $local_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: dbw service
# Description:       Run dbw service
### END INIT INFO

# Carry out specific functions when asked to by the system
case "$1" in
  start)
    echo "Starting dbw..."
    sudo -u sean bash -c '/home/sean/dbw-start.sh'
    ;;
  stop)
    echo "Stopping dbw..."
    sudo -u sean bash -c '/home/sean/dbw-stop.sh'
    sleep 2
    ;;
  *)
    echo "Usage: /etc/init.d/dbw {start|stop}"
    exit 1
    ;;
esac

exit 0
