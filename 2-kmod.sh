#!/bin/bash
if [ -f $PROGRESS_DIR/2-kmod ] ; then
	exit 0
fi
echo "building kmod..."
set -e
tar xf kmod-${kmod_v}.tar.xz
cd kmod-${kmod_v}
./configure --prefix=/usr --bindir=/bin --sysconfdir=/etc --with-rootlibdir=/lib --with-xz --with-zlib
make
make install
for target in depmod insmod lsmod modinfo modprobe rmmod ; do
	ln -s ../bin/kmod /sbin/$target
done
ln -s kmod /bin/lsmod
cd ..
rm -rf kmod-${kmod_v}
touch $PROGRESS_DIR/2-kmod
