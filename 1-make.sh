#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/1-make ] ; then
	exit 0
fi

echo "building make..."

set -e

cd $MINL/sources
rm -rf make-${make_v}
tar xf make-${make_v}.tar.gz
cd make-${make_v}

./configure \
    --prefix=/usr \
    --without-guile \
    --host=$MINL_TGT \
    --build=$(build-aux/config.guess)
make
make DESTDIR=$MINL install

cd ..
rm -rf make-${make_v}
touch $PROGRESS_DIR/1-make
