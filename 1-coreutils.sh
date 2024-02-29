#!/bin/bash

export STAGE=1

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/1-coreutils ] ; then
    exit 0
fi

echo "building coreutils..."

set -e

cd $MINL/sources
rm -rf coreutils-${coreutils_v}
tar xf coreutils-${coreutils_v}.tar.xz
cd coreutils-${coreutils_v}

./configure \
    --prefix=/usr \
    --host=$MINL_TGT \
    --build=$(build-aux/config.guess) \
    --enable-install-program=hostname \
    --enable-no-install-program=kill,uptime
make
make DESTDIR=$MINL install

mv $MINL/usr/bin/chroot $MINL/usr/sbin
mkdir -p $MINL/usr/share/man/man8
mv $MINL/usr/share/man/man1/chroot.1 $MINL/usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/' $MINL/usr/share/man/man8/chroot.8

cd ..
rm -rf coreutils-${coreutils_v}
touch $PROGRESS_DIR/1-coreutils
