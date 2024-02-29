#!/bin/bash

export STAGE=1

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/1-sed ] ; then
    exit 0
fi

echo "building sed..."

set -e

cd $MINL/sources
rm -rf sed-${sed_v}
tar xf sed-${sed_v}.tar.xz
cd sed-${sed_v}

./configure \
    --prefix=/usr \
    --host=$MINL_TGT \
    --build=$(./build-aux/config.guess)
make
make DESTDIR=$MINL install

cd ..
rm -rf sed-${sed_v}
touch $PROGRESS_DIR/1-sed
