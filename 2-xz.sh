#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-xz ] ; then
	exit 0
fi

echo "building xz..."

set -e

tar xf xz-${xz_v}.tar.xz
cd xz-${xz_v}

if [ "$KEEP_STATIC_LIBS" == "0" ] ; then
disable_static="--disable-static"
else
disable_static=""
fi

./configure \
    --prefix=/usr \
    --docdir=/usr/share/doc/xz-${xz_v} \
    $disable_static
make
make install

cd ..
rm -rf xz-${xz_v}
touch $PROGRESS_DIR/2-xz
