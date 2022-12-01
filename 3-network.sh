#!/bin/bash

if [ -f $PROGRESS_DIR/3-network ] ; then
	exit 0
fi

echo "configuring network..."

set -e

cat > /etc/sysconfig/ifconfig.eth0 << "EOF"
ONBOOT=yes
IFACE=eth0
# uncomment these for a static ip
#SERVICE=ipv4-static
#IP=192.168.1.9
#GATEWAY=192.168.1.1
#PREFIX=24
#BROADCAST=192.168.1.255
# comment these out for a static ip
SERVICE="dhcpcd"
EOF

cat > /etc/resolv.conf.head << "EOF"
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF

echo "minl" > /etc/hostname

cat > /etc/hosts << "EOF"
127.0.0.1 localhost
EOF

touch $PROGRESS_DIR/3-network
