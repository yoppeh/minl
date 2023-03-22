#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-eudev ] ; then
	exit 0
fi

echo "building eudev..."

set -e

tar xf eudev-${eudev_v}.tar.gz
cd eudev-${eudev_v}

./configure \
    --prefix=/usr \
    --bindir=/usr/sbin \
    --sysconfdir=/etc \
if [ "$KEEP_STATIC_LIBS" == "0" ] ; then
    --disable-static \
fi
    --enable-manpages
make
mkdir -p /usr/lib/udev/rules.d
mkdir -p /etc/udev/rules.d
make install
tar xf ../udev-lfs-${udev_lfs_v}.tar.xz
make -f udev-lfs-${udev_lfs_v}/Makefile.lfs install
udevadm hwdb --update

cd ..
rm -rf eudev-${eudev_v}
touch $PROGRESS_DIR/2-eudev
