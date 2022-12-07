#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/1-findutils ] ; then
	exit 0
fi

echo "building findutils..."

set -e

cd $MINL/sources
rm -rf findutils-${findutils_v}
tar xf findutils-${findutils_v}.tar.xz
cd findutils-${findutils_v}

./configure \
    --prefix=/usr \
    --localstatedir=/var/lib/locate \
    --host=$MINL_TGT \
    --build=$(build-aux/config.guess)
make
make DESTDIR=$MINL install

cd ..
rm -rf findutils-${findutils_v}
touch $PROGRESS_DIR/1-findutils
