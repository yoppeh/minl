#!/bin/bash

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
    --with-system-zlib
make tooldir=/usr
make tooldir=/usr install
rm -f /usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes}.a

cd ../..
rm -rf binutils-${binutils_v}
touch $PROGRESS_DIR/2-binutils
