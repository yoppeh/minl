#!/bin/bash

if [ -f $PROGRESS_DIR/2-m4 ] ; then
	exit 0
fi

echo "building m4..."

set -e

tar xf m4-${m4_v}.tar.xz
cd m4-${m4_v}

./configure --prefix=/usr
make
make install

cd ..
rm -rf m4-${m4_v}
touch $PROGRESS_DIR/2-m4
