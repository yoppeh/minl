#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-libpng ] ; then
	exit 0
fi

echo "building libpng..."

set -e

tar xf libpng-${libpng_v}.tar.xz
cd libpng-${libpng_v}

gzip -cd ../libpng-1.6.37-apng.patch.gz | patch -p1

./configure \
	--prefix=/usr \
	--disable-static
make
make install
mkdir /usr/share/doc/libpng-${libpng_v}
cp README libpng-manual.txt /usr/share/doc/libpng-${libpng_v}

cd ..
rm -rf libpng-${libpng_v}
touch $PROGRESS_DIR/2-libpng
