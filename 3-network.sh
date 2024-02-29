#!/bin/bash

export STAGE=3

. ./environment.sh
. ./package-versions.sh

if [ -f $PROGRESS_DIR/3-network ] ; then
    exit 0
fi

echo "configuring network..."

set -e

if [ "$ETH_DEV" != "" ] ; then
cat > /etc/systemd/network/10-eth-dhcp.network << EOF
[Match]
Name=${ETH_DEV}

[Network]
DHCP=ipv4

[DHCPv4]
UseDomains=true
EOF
fi

if [ "$WLAN_DEV" != "" ] ; then
cat > /etc/systemd/network/20-wifi-dhcp.network << EOF
[Match]
Name=${WLAN_DEV}

[Network]
DHCP=ipv4

[DHCPv4]
UseDomains=true
EOF
fi

echo "${HOSTNAME}" > /etc/hostname

cat > /etc/hosts << "EOF"
127.0.0.1 localhost ${HOSTNAME}
::1 localhost ip6-localhost ip6-loopback
EOF

touch $PROGRESS_DIR/3-network
