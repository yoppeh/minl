#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/1-tar ] ; then
	exit 0
fi

echo "building tar..."

set -e

cd $MINL/sources
rm -rf tar-${tar_v}
tar xf tar-${tar_v}.tar.xz
cd tar-${tar_v}

./configure \
    --prefix=/usr \
    --host=$MINL_TGT \
    --build=$(build-aux/config.guess)
make
make DESTDIR=$MINL install

cd ..
rm -rf tar-${tar_v}
touch $PROGRESS_DIR/1-tar
