#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-kmod ] ; then
    exit 0
fi

echo "building kmod..."

set -e

tar xf kmod-${kmod_v}.tar.xz
cd kmod-${kmod_v}

./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --with-openssl \
    --with-xz \
    --with-zstd \
    --with-zlib
make
make install

for target in depmod insmod lsmod modinfo modprobe rmmod ; do
    ln -sf ../bin/kmod /usr/sbin/$target
done

ln -sf kmod /usr/bin/lsmod

cd ..
rm -rf kmod-${kmod_v}
touch $PROGRESS_DIR/2-kmod
