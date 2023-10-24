#!/bin/bash
# INFO: run this script on centered device which provides the bridge

# read from stdin 
read -p "Enter bridge-name [br0]:" BRIDGE_NAME
name=${name:-BRIDGE_NAME}

read -p "Enter bridge-ip-adress [192.168.0.244]:" BRIDGE_IP
name=${name:-BRIDGE_IP}

read -p "Enter bridge-cidr [24]:" BRIDGE_CIDR
name=${name:-BRIDGE_CIDR}

read -p "Enter name of inteface a [eth1]:" IF_A
name=${name:-IF_A}

read -p "Enter name of inteface b [eth1]:" IF_B
name=${name:-IF_B}

# read ips and cidrs for given interface-names
IF_A_IP_AND_MASK=$(/sbin/ip -o -4 addr list $IF_A | awk '{print $4}' | cut -d/ -f1)
IF_B_IP_AND_MASK=$(/sbin/ip -o -4 addr list $IF_B | awk '{print $4}' | cut -d/ -f1)

# todo: get ip from $IF_A and $IF_B

# print config-info
echo "Your configuration: +++++++++++++++++++++++++++"
echo "$($BRIDGE_NAME): $($BRIDGE_IP)/$($BRIDGE_CIDR)" 
echo "Between $($IF_A) [$($IF_A_IP_AND_MASK)] and $($IF_B) [$($IF_B_IP_AND_MASK)]"
echo "+++++++++++++++++++++++++++++++++++++++++++++++"

read -r -p "Are you sure? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    run_setup
else
    echo "Bridge not implemented. Finished."
    exit(0)
fi


run_setup() {
    # setup bridge
    # 1. create bridge and activate
    sudo ip link add name $BRIDGE_NAME type bridge
    sudo ip link set dev $BRIDGE_NAME up

    # 2. link devices to bridge
    sudo ip link set $IF_A master $BRIDGE_NAME
    sudo ip link set $IF_B master $BRIDGE_NAME

    # add ip to bridge
    sudo ip a add $BRIDGE_IP/$BRIDGE_CIDR dev $BRIDGE_NAME
    # sudo ip a del $IP_IF_A/$CIDR_IF_A dev eno1 # $BRIDGE_NAME now is interface which is available from remote
}