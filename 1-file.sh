#!/bin/bash

export STAGE=1

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/1-file ] ; then
    exit 0
fi

echo "building file..."

set -e

cd $MINL/sources
rm -rf file-${file_v}
tar xf file-${file_v}.tar.gz
cd file-${file_v}

mkdir build
pushd build
../configure \
    --disable-bzlib \
    --disable-libseccomp \
    --disable-xzlib \
    --disable-zlib
make
popd

./configure \
    --prefix=/usr \
    --host=$MINL_TGT \
    --build=$(./config.guess)
make FILE_COMPILE=$(pwd)/build/src/file
make DESTDIR=$MINL install
rm $MINL/usr/lib/libmagic.la

cd ..
rm -rf file-${file_v}
touch $PROGRESS_DIR/1-file
