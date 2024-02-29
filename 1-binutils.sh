#!/bin/bash

export STAGE=1

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/1-binutils-$PASS ] ; then
    exit 0
fi

echo "building binutils pass $PASS..."

set -e

cd $MINL/sources
rm -rf binutils-${binutils_v}
tar xf binutils-${binutils_v}.tar.xz
cd binutils-${binutils_v}

if [ "$PASS" == "2" ] ; then
    sed '6009s/$add_dir//' -i ltmain.sh
fi

mkdir build
cd build

if [ "$PASS" == "1" ] ; then
	../configure \
        --prefix=$MINL/tools \
        --with-sysroot=$MINL \
        --target=$MINL_TGT \
        --disable-nls \
        --disable-werror \
        --enable-gprofng=no \
        --enable-default-hash-style=gnu
else
    ../configure \
        --prefix=/usr \
        --build=$(../config.guess) \
        --host=$MINL_TGT \
        --disable-nls \
        --enable-shared \
        --enable-gprofng=no \
        --disable-werror \
        --enable-64-bit-bfd \
        --enable-default-hash-style=gnu
fi
make

if [ "$PASS" == "1" ] ; then 
    make install
else
    make DESTDIR=$MINL install
    rm $MINL/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la}
fi

cd $MINL/sources
rm -rf binutils-${binutils_v}
touch $PROGRESS_DIR/1-binutils-$PASS
