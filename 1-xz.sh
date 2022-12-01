#!/bin/bash

if [ -f $PROGRESS_DIR/1-xz ] ; then
	exit 0
fi

echo "building xz..."

set -e

cd $MINL/sources
rm -rf xz-${xz_v}
tar xf xz-${xz_v}.tar.xz
cd xz-${xz_v}

./configure \
    --prefix=/usr \
    --host=$MINL_TGT \
    --build=$(build_aux/config.guess) \
    --disable-static \
    --docdir=/usr/share/doc/xz-5.2.6
make
make DESTDIR=$MINL install
rm $MINL/usr/lib/liblzma.la

cd ..
rm -rf xz-${xz_v}
touch $PROGRESS_DIR/1-xz
