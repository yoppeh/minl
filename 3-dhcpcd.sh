#!/bin/bash
if [ -f $PROGRESS_DIR/2-dhcpcd ] ; then
	exit 0
fi

echo "building dhcpcd..."

set -e

install -v -m700 -d /var/lib/dhcpcd
groupadd -g 52 dhcpcd
useradd -c 'dhcpcd PrivSep' -d /var/lib/dhcpcd -g dhcpcd -s /bin/false -u 52 dhcpcd
chown -v dhcpcd:dhcpcd /var/lib/dhcpcd

tar xf dhcpcd-${dhcpcd_v}.tar.xz
cd dhcpcd-${dhcpcd_v}

sed '/Deny everything else/i SECCOMP_ALLOW(__NR_getrandom),' -i src/privsep-linux.c
./configure --prefix=/usr --sysconfdir=/etc --libexecdir=/usr/lib/dhcpcd --dbdir=/var/lib/dhcpcd --runstatdir=/run --privsepuser=dhcpcd
make
make install

cat > /etc/sysconfig/ifconfig.eth0 << "EOF"
ONBOOT="yes"
IFACE="eth0"
SERVICE="dhcpcd"
DHCP_START="-b -q"
DHCP_STOP="-k"
EOF

cat > /etc/resolv.conf.head << "EOF"
# OpenDNS servers
nameserver 208.67.222.222
nameserver 208.67.220.220
ENOF

cd ..
rm -rf dhcpcd-${dhcpcd_v}

tar xf blfs-bootscripts-${blfs_bootscripts_v}.tar.xz
cd blfs-bootscripts-${blfs_bootscripts_v}
make install-service-dhcpcd
cd ..
rm -rf blfs-bootscripts-${blfs_bootscripts_v}

touch $PROGRESS_DIR/2-dhcpcd
