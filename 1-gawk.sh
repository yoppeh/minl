#!/bin/bash

export STAGE=1

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/1-gawk ] ; then
    exit 0
fi

echo "building gawk..."

set -e

cd $MINL/sources
rm -rf gawk-${gawk_v}
tar xf gawk-${gawk_v}.tar.xz
cd gawk-${gawk_v}

sed -i 's/extras//' Makefile.in
./configure \
    --prefix=/usr \
    --host=$MINL_TGT \
    --build=$(build-aux/config.guess)
make
make DESTDIR=$MINL install

cd ..
rm -rf gawk-${gawk_v}
touch $PROGRESS_DIR/1-gawk
