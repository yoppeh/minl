#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-util-linux-$PASS ] ; then
    exit 0
fi

echo "building util-linux..."

set -e

tar xf util-linux-${util_linux_v}.tar.xz
cd util-linux-${util_linux_v}

if [ "$PASS" == "1" ] ; then
    mkdir -p /var/lib/hwclock
    ./configure \
        --libdir=/usr/lib \
        --runstatedir=/run \
        --disable-chfn-chsh \
        --disable-login \
        --disable-nologin \
        --disable-su \
        --disable-setpriv \
        --disable-runuser \
        --disable-pylibmount \
        --disable-static \
        --without-python \
        ADJTIME_PATH=/var/lib/hwclock/adjtime \
        --docdir=/usr/share/doc/util-linux-${util_linux_v}
else
    sed -i '/test_mkfds/s/^/#/' tests/helpers/Makemodule.am
    ./configure \
        --bindir=/usr/bin    \
        --libdir=/usr/lib    \
        --runstatedir=/run   \
        --sbindir=/usr/sbin  \
        --disable-chfn-chsh  \
        --disable-login      \
        --disable-nologin    \
        --disable-su         \
        --disable-setpriv    \
        --disable-runuser    \
        --disable-pylibmount \
        --disable-static     \
        --without-python     \
        ADJTIME_PATH=/var/lib/hwclock/adjtime \
        --docdir=/usr/share/doc/util-linux-2.39.1 
fi
make
make install

cd ..
rm -rf util-linux-${util_linux_v}
touch $PROGRESS_DIR/2-util-linux-$PASS
