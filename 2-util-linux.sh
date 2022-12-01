#!/bin/bash

if [ -f $PROGRESS_DIR/2-util-linux-$PASS ] ; then
	exit 0
fi

echo "building util-linux..."

set -e

tar xf util-linux-${util_linux_v}.tar.xz
cd util-linux-${util_linux_v}
mkdir -p /var/lib/hwclock

if [ "$PASS" == "1" ] ; then
    ./configure \
        ADJTIME_PATH=/var/lib/hwclock/adjtime \
        --libdir=/usr/lib \
        --docdir=/usr/share/doc/util-linux-${util_linux_v} \
        --disable-chfn-chsh \
        --disable-login \
        --disable-nologin \
        --disable-su \
        --disable-setpriv \
        --disable-runuser \
        --disable-pylibmount \
        --disable-static \
        --without-python \
        runstatedir=/run
else
    ./configure \
        ADJTIME_PATH=/var/lib/hwclock/adjtime \
        --bindir=/usr/bin \
        --libdir=/usr/lib \
        --sbindir=/usr/sbin \
        --docdir=/usr/share/doc/util-linux-${util_linux_v} \
        --disable-chfn-chsh \
        --disable-login \
        --disable-nologin \
        --disable-su \
        --disable-setpriv \
        --disable-runuser \
        --disable-pylibmount \
        --disable-static \
        --without-python \
        --without-systemd \
        --without-systemdsystemunitdir
fi
make
make install

cd ..
rm -rf util-linux-${util_linux_v}
touch $PROGRESS_DIR/2-util-linux-$PASS
