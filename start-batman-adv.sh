#!/bin/bash

sudo ip link set dev eth1 down
sleep 5s
sudo batctl if add eth1
sleep 5s
sudo ip link set dev eth1 up
sleep 5s
sudo ip link set dev bat0 up
sleep 5s

avahi-autoipd bat0

exec bash