#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-gmp ] ; then
    exit 0
fi

echo "building gmp..."

set -e

rm -rf gmp-${gmp_v}
tar xf gmp-${gmp_v}.tar.xz
cd gmp-${gmp_v}

./configure \
    --prefix=/usr \
    --enable-cxx \
    --disable-static \
    --docdir=/usr/share/doc/gmp-${gmp_v}
make
make install

cd ..
rm -rf gmp-${gmp_v}
touch $PROGRESS_DIR/2-gmp
