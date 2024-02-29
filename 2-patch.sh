#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-patch ] ; then
    exit 0
fi

echo "building patch..."

set -e

tar xf patch-${patch_v}.tar.xz
cd patch-${patch_v}

./configure --prefix=/usr
make
make install

cd ..
rm -rf patch-${patch_v}
touch $PROGRESS_DIR/2-patch
