#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-expat ] ; then
	exit 0
fi

echo "building expat..."

set -e

tar xf expat-${expat_v}.tar.xz
cd expat-${expat_v}

if [ "$KEEP_STATIC_LIBS" == "0" ] ; then
disable_static="--disable-static"
else
disable_static=""
fi

./configure \
    --prefix=/usr \
    $disable_static \
    --docdir=/usr/share/doc/expat-${expat_v}
make
make install

cd ..
rm -rf expat-${expat_v}
touch $PROGRESS_DIR/2-expat
