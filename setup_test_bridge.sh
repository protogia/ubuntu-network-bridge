#!/bin/bash
# INFO: run this script on centered device which provides the bridge

# todo: read from commandline these params ...
BRIDGE_NAME=""
BRIDGE_IP=""
BRIDGE_CIDR=""
IF_A=""
IF_B=""

# 1. create bridge and activate
sudo ip link add name $BRIDGE_NAME type bridge
sudo ip link set dev $BRIDGE_NAME up

# 2. link devices to bridge
sudo ip link set $IF_A master $BRIDGE_NAME
sudo ip link set $IF_B master $BRIDGE_NAME

# add ip to bridge
sudo ip a add $BRIDGE_IP/$BRIDGE_CIDR dev $BRIDGE_NAME

# todo: get ip from $IF_A and save to $IP_IF_A
# todo: get cidr from $IF_A and save to $CIDR_IF_A
sudo ip a del $IP_IF_A/$CIDR_IF_A dev eno1 # $BRIDGE_NAME ist nun interface, welches von außen erreichbar ist
