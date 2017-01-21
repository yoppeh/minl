#!/bin/bash
if [ -f $PROGRESS_DIR/3-kernel ] ; then
	exit 0
fi
echo "building kernel..."
set -e
cd /sources
tar xf linux-${linux_v}.tar.xz
chown -R 0:0 linux-${linux_v}
cd linux-${linux_v}
make mrproper
cp ../$KERNEL_CONFIG .config
sed -e '/sk_sndbuf/s/u32/int/' -e '/sk_rcvbuf/s/u32/int/' -i.bak net/core/sock.c
make
make modules_install
cp arch/x86/boot/bzImage /boot/vmlinuz-${linux_v}-minl
cp System.map /boot/System.map-${linux_v}
cp .config /boot/config-${linux_v}
install -d /usr/share/doc/linux-${linux_v}
cp -r Documentation/* /usr/share/doc/linux-${linux_v}
install -m755 -d /etc/modprobe.d
cat > /etc/modprobe.d/usb.conf << "EOF"
install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true
EOF
touch $PROGRESS_DIR/3-kernel
