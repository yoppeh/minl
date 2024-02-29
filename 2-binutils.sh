#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-binutils ] ; then
    exit 0
fi

echo "building binutils..."

set -e

rm -rf binutils-${binutils_v}
tar xf binutils-${binutils_v}.tar.xz
cd binutils-${binutils_v}
mkdir build
cd build

../configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --enable-gold \
    --enable-ld=default \
    --enable-plugins \
    --enable-shared \
    --disable-werror \
    --enable-64-bit-bfd \
    --with-system-zlib \
    --enable-default-hash-style=gnu
make tooldir=/usr
make tooldir=/usr install
rm -f /usr/lib/lib{bfd,ctf,ctf-nobfd,gprofng,opcodes,sframe}.a

cd ../..
rm -rf binutils-${binutils_v}
touch $PROGRESS_DIR/2-binutils
