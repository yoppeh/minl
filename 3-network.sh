#!/bin/bash

. ./environment.sh
. ./package-versions.sh

if [ -f $PROGRESS_DIR/3-network ] ; then
	exit 0
fi

echo "configuring network..."

set -e

cat > /etc/systemd/network/10-eth-dhcp.network << EOF
[Match]
Name=${ETH_DEV}

[Network]
DHCP=ipv4

[DHCPv4]
UseDomains=true
EOF

cat > /etc/systemd/network/20-wifi-dhcp.network << EOF
[Match]
Name=${WLAN_DEV}

[Network]
DHCP=ipv4

[DHCPv4]
UseDomains=true
EOF

cat > /etc/resolv.conf << "EOF"
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF

echo "${HOSTNAME}" > /etc/hostname

cat > /etc/hosts << "EOF"
127.0.0.1 localhost ${HOSTNAME}
EOF

touch $PROGRESS_DIR/3-network
