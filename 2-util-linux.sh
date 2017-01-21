#!/bin/bash
if [ -f $PROGRESS_DIR/2-utillinux ] ; then
	exit 0
fi
echo "building utillinux..."
set -e
tar xf util-linux-${utillinux_v}.tar.xz
cd util-linux-${utillinux_v}
mkdir -p /var/lib/hwclock
./configure ADJTIME_PATH=/vr/lib/hwclock/adjtime --docdir=/usr/share/doc/util-linux-${utillinux_v} --disable-chfn-chsh --disable-login --disable-nologin --disable-su --disable-setpriv --disable-runuser --disable-pylibmount --disable-static --without-python --without-systemd --without-systemdsystemunitdir
make
make install
cd ..
rm -rf util-linux-${utillinux_v}
touch $PROGRESS_DIR/2-utillinux
