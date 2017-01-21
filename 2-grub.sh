#!/bin/bash
if [ -f $PROGRESS_DIR/2-grub ] ; then
	exit 0
fi
echo "building grub..."
set -e
tar xf grub-${grub_v}.tar.xz
cd grub-${grub_v}
./configure --prefix=/usr --sbindir=/sbin --sysconfdir=/etc --disable-efiemu --disable-werror
make
make install
cd ..
rm -rf grub-${grub_v}
touch $PROGRESS_DIR/2-grub
