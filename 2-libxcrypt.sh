#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-libxcrypt ] ; then
    exit 0
fi

echo "building libxcrypt..."

set -e

tar xf libxcrypt-${libxcrypt_v}.tar.xz
cd libxcrypt-${libxcrypt_v}

./configure \
    --prefix=/usr \
    --enable-hashes=strong,glibc \
    --enable-obsolete-api=no \
    --disable-static \
    --disable-failure-tokens

make
make install

cd ..
rm -rf libxcrypt-${libxcrypt_v}
touch $PROGRESS_DIR/2-libxcrypt
