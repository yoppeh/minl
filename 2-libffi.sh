#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-libffi ] ; then
	exit 0
fi

echo "building libffi..."

set -e

tar xf libffi-${libffi_v}.tar.gz
cd libffi-${libffi_v}

if [ "$KEEP_STATIC_LIBS" == "0" ] ; then
disable_static="--disable-static"
else
disable_static=""
fi

./configure \
    --prefix=/usr \
    $disable_static \
    --with-gcc-arch=native
make
make install

cd ..
rm -rf libffi-${libffi_v}
touch $PROGRESS_DIR/2-libffi
