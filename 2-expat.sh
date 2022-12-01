#!/bin/bash

if [ -f $PROGRESS_DIR/2-expat ] ; then
	exit 0
fi

echo "building expat..."

set -e

tar xf expat-${expat_v}.tar.xz
cd expat-${expat_v}

./configure \
    --prefix=/usr \
    --disable-static \
    --docdir=/usr/share/doc/expat-${expat_v}
make
make install

cd ..
rm -rf expat-${expat_v}
touch $PROGRESS_DIR/2-expat
