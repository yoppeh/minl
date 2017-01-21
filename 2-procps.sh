#!/bin/bash
if [ -f $PROGRESS_DIR/2-procps ] ; then
	exit 0
fi
echo "building procps..."
set -e
tar xf procps-ng-${procps_v}.tar.xz
cd procps-ng-${procps_v}
./configure --prefix=/usr --exec-prefix= --libdir=/usr/lib --docdir=/usr/share/doc/procps-ng-${procps_v} --disable-static --disable-kill
make
sed -i -r 's|(pmap_initname)\\\$|\1|' testsuite/pmap.test/pmap.exp
make install
mv /usr/lib/libprocps.so.* /lib
ln -sf ../../lib/$(readlink /usr/lib/libprocps.so) /usr/lib/libprocps.so
cd ..
rm -rf procps-ng-${procps_v}
touch $PROGRESS_DIR/2-procps
