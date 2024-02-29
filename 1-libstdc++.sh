#!/bin/bash

export STAGE=1

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/1-libstdc ] ; then
    exit 0
fi

echo "building libstdc++..."

set -e

cd $MINL/sources
rm -rf gcc-${gcc_v}
tar xf gcc-${gcc_v}.tar.xz
cd gcc-${gcc_v}
rm -rf build
mkdir build
cd build

../libstdc++-v3/configure \
    --host=${MINL_TGT} \
    --build=$(../config.guess) \
    --prefix=/usr \
    --disable-multilib \
    --disable-nls \
    --disable-libstdcxx-pch \
    --with-gxx-include-dir=/tools/$MINL_TGT/include/c++/${gcc_v}
make
make DESTDIR=$MINL install
rm $MINL/usr/lib/lib{stdc++{,exp,fs},supc++}.la

cd $MINL/sources
rm -rf gcc-${gcc_v}
touch $PROGRESS_DIR/1-libstdc
