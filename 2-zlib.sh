#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-zlib ] ; then
	exit 0
fi

echo "building zlib..."

set -e

tar xf zlib-${zlib_v}.tar.xz
cd zlib-${zlib_v}

./configure --prefix=/usr
make
make install
if [ "$KEEP_STATIC_LIBS" == "0" ] ; then
rm -f /usr/lib/libz.a
fi

cd ..
rm -rf zlib-${zlib_v}
touch $PROGRESS_DIR/2-zlib
