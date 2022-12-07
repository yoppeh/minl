#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-mpfr ] ; then
	exit 0
fi

echo "building mpfr..."

set -e

rm -rf mpfr-${mpfr_v}
tar xf mpfr-${mpfr_v}.tar.xz
cd mpfr-${mpfr_v}

./configure \
    --prefix=/usr \
    --disable-static \
    --enable-thread-safe \
    --docdir=/usr/share/doc/mpfr-${mpfr_v}
make
make install

cd ..
rm -rf mpfr-${mpfr_v}
touch $PROGRESS_DIR/2-mpfr
