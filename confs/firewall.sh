#!/bin/bash

# pass eth0 through wlan0, using nat

modprobe nf_conntrack
modprobe nf_conntrack_ipv4
modprobe nf_nat
modprobe iptable_nat  

EXTIF="wlp4s0"
INTIF="enp0s31f6"

echo "1" > /proc/sys/net/ipv4/ip_forward
echo "1" > /proc/sys/net/ipv4/ip_dynaddr

iptables -P INPUT ACCEPT
iptables -F INPUT
iptables -P OUTPUT ACCEPT
iptables -F OUTPUT 
iptables -P FORWARD DROP
iptables -F FORWARD 
iptables -t nat -F
iptables -A FORWARD -i $EXTIF -o $INTIF -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i $INTIF -o $EXTIF -j ACCEPT
iptables -t nat -A POSTROUTING -o $EXTIF -j MASQUERADE

#ip link set eth0 down
#ip addr flush dev eth0
#ip addr add 192.168.3.1/24 dev eth0
#ip link set eth0 up

#/etc/init.d/isc-dhcp-server start
