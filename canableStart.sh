#!/bin/bash

interface=can0
if [ $# -gt 0 ]; then
    interface=$1
fi

dev=`ls /dev/ttyACM*`

echo "Interface: " $interface
echo "Device   : " $dev

# Link can0 to the device
echo "Link can0 to the device"
echo "EXECUTING: sudo slcand -o -c -s8 $dev can0 "      
sudo slcand -o -c -s8 $dev can0          #--- 1M
#sudo slcand -o -c -s0 /dev/ttyACM0 can0 #--- causes unhappy can network 

# set buffer on can0
echo "Set buffer on can0"
echo "EXECUTING: sudo ifconfig can0 txqueuelen 1000"
sudo ifconfig can0 txqueuelen 1000

# set bitrate on can0
echo "Set bitrate on can0"
echo "EXECUTING: sudo ip link set $interface type can bitrate 1000000"
sudo ip link set $interface type can bitrate 1000000

# turn can0 network up
echo "Turn can0 network up"
echo "EXECUTING: sudo ifconfig $interface up"
sudo ifconfig $interface up
