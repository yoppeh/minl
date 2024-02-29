#!/bin/bash

export STAGE=1

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/1-patch ] ; then
    exit 0
fi

echo "building patch..."

set -e

cd $MINL/sources
rm -rf patch-${patch_v}
tar xf patch-${patch_v}.tar.xz
cd patch-${patch_v}

./configure \
    --prefix=/usr \
    --host=$MINL_TGT \
    --build=$(build-aux/config.guess)
make
make DESTDIR=$MINL install

cd ..
rm -rf patch-${patch_v}
touch $PROGRESS_DIR/1-patch
