#!/bin/bash
if [ -f $PROGRESS_DIR/1-fakeroot ] ; then
	exit 0
fi
echo "building fakeroot..."
set -e
cd $MINL/sources
rm -rf fakeroot-${fakeroot_v}
tar xf fakeroot_${fakeroot_v}.orig.tar.xz
cd fakeroot-${fakeroot_v}
cd doc
mv Makefile.am Makefile.am.original
cat Makefile.am.original | sed 's/SUBDIRS/#SUBDIRS/' > Makefile.am
cd ..
./bootstrap
./configure --prefix=/tools  --libdir=/tools/usr/lib/libfakeroot --with-ipc=sysv
make
make install
cd ..
rm -rf fakeroot-${fakeroot_v}
touch $PROGRESS_DIR/1-fakeroot
