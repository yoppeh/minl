#!/bin/bash

. ./environment.sh
. ./package-versions.sh

if [ -f $PROGRESS_DIR/3-kernel ] ; then
	exit 0
fi

echo "building kernel..."

set -e

cd /sources
tar xf linux-${linux_v}.tar.xz
chown -R 0:0 linux-${linux_v}
cp -R linux-${linux_v} /usr/src
ln -s /usr/src/linux-${linux_v} /usr/src/linux
cd linux-${linux_v}

make mrproper
cp ../$KERNEL_CONFIG .config
make
make modules_install
cp arch/x86/boot/bzImage /boot/minl/vmlinuz-${linux_v}-minl
cp System.map /boot/minl/System.map-${linux_v}
cp .config /boot/minl/config-${linux_v}
install -d /usr/share/doc/linux-${linux_v}
cp -r Documentation/* /usr/share/doc/linux-${linux_v}
install -m755 -d /etc/modprobe.d

cat > /etc/modprobe.d/usb.conf << "EOF"
install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true
EOF

cd /sources
rm -rf linux-${linux_v}

touch $PROGRESS_DIR/3-kernel
