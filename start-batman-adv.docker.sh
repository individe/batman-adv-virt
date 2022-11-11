#!/bin/bash

ip link set dev eth0 down
sleep 5s
batctl if add eth0
sleep 5s
ip link set dev eth0 up
sleep 5s
ip link set dev bat0 up
sleep 5s

avahi-autoipd bat0 &

exec bash