#!/bin/bash

export STAGE=1

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/1-diffutils ] ; then
    exit 0
fi

echo "building diffutils..."

set -e

cd $MINL/sources
rm -rf diffutils-${diffutils_v}
tar xf diffutils-${diffutils_v}.tar.xz
cd diffutils-${diffutils_v}

./configure \
    --prefix=/usr \
    --host=$MINL_TGT \
    --build=$(./build-aux/config.guess)
make
make DESTDIR=$MINL install

cd ..
rm -rf diffutils-${diffutils_v}
touch $PROGRESS_DIR/1-diffutils
