#!/bin/bash

if [ -f $PROGRESS_DIR/1-m4 ] ; then 
	exit 0
fi

echo "building m4..."

set -e

cd $MINL/sources
rm -rf m4-${m4_v}
tar xf m4-${m4_v}.tar.xz
cd m4-${m4_v}

./configure \
    --prefix=/usr \
    --host=$MINL_TGT \
    --build=$(build-aux/config.guess)
make
make DESTDIR=$MINL install

cd ..
rm -rf m4-${m4_v}
touch $PROGRESS_DIR/1-m4
