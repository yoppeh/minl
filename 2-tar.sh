#!/bin/bash

if [ -f $PROGRESS_DIR/2-tar ] ; then
	exit 0
fi

echo "building tar..."

set -e

tar xf tar-${tar_v}.tar.xz
cd tar-${tar_v}

FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=/usr
make
make install

cd ..
rm -rf tar-${tar_v}
touch $PROGRESS_DIR/2-tar
