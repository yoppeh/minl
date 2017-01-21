#!/bin/bash
if [ -f $PROGRESS_DIR/2-eudev ] ; then
	exit 0
fi
echo "building eudev..."
set -e
tar xf eudev-${eudev_v}.tar.gz
cd eudev-${eudev_v}
sed -r -i 's|/usr(/bin/test)|\1|' test/udev-test.pl
sed -i '/keyboard_lookup_key/d' src/udev/udev-builtin-keyboard.c
cat > config.cache << "EOF"
HAVE_BLKID=1
BLKID_LIBS="-lblkid"
BLKID_CFLAGS="-I/tools/include"
EOF
./configure --prefix=/usr --bindir=/sbin --sbindir=/sbin --libdir=/usr/lib --sysconfdir=/etc --libexecdir=/lib --with-rootprefix= --with-rootlibdir=/lib --enable-manpages --disable-static --config-cache
LIBRARY_PATH=/tools/lib make
mkdir -p /lib/udev/rules.d
mkdir -p /etc/udev/rules.d
make LD_LIBRARY_PATH=/tools/lib install
tar xf ../udev-lfs-20140408.tar.bz2
make -f udev-lfs-20140408/Makefile.lfs install
LD_LIBRARY_PATH=/tools/lib udevadm hwdb --update
cd ..
rm -rf eudev-${eudev_v}
touch $PROGRESS_DIR/2-eudev
