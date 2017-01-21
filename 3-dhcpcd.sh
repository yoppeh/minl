#!/bin/bash
if [ -f $PROGRESS_DIR/2-dhcpcd ] ; then
	exit 0
fi
echo "building dhcpcd..."
set -e
tar xf dhcpcd-${dhcpcd_v}.tar.xz
cd dhcpcd-${dhcpcd_v}
./configure --libexecdir=/lib/dhcpcd --dbdir=/var/lib/dhcpcd
make
make install
cat > /etc/sysconfig/ifconfig.eth0 << "EOF"
ONBOOT="yes"
IFACE="eth0"
SERVICE="dhcpcd"
DHCP_START="-b -q"
DHCP_STOP="-k"
EOF
cd ..
rm -rf dhcpcd-${dhcpcd_v}
touch $PROGRESS_DIR/2-dhcpcd
