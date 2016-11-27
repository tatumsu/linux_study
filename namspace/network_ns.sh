#!/bin/bash

# create a new network namespace "nstest"
sudo ip netns add nstest

# show all network namespance
sudo ip netns list

# add a new virtual network interface
sudo ip link add veth0 type veth peer name veth1

# put "veth1" into the newly created namespace "nstest"
sudo ip link set veth1 netns nstest

# setup ip address for the virtual network interface and bring it up
sudo ip netns exec nstest ifconfig veth1 10.1.1.1/24 up
sudo ifconfig veth0 10.1.1.2/24 up

# add route for the new network namespace "nstest"
sudo ip netns exec nstest route add default gw 10.1.1.2

# enable host network package forwrading
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward

# enable SNAT
sudo iptables -A POSTROUTING -t nat -j MASQUERADE -s 10.1.1.0/24 

# ping outside from the newly created network namespace
sudo ip netns exec nstest ping h5.yit.com

# findout other side of a virtual network interface pair
sudo ethtool -S vethxxx

# delete the network namespace
#sudo ip netns delete nstest
