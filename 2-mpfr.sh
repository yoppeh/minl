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

sed -e 's/+01,234,567/+1,234,567 /' \
    -e 's/13.10Pd/13Pd/'            \
    -i tests/tsprintf.c

if [ "$KEEP_STATIC_LIBS" == "0" ] ; then
disable_static="--disable-static"
else
disable_static=""
fi

./configure \
    --prefix=/usr \
	$disable_static \
    --enable-thread-safe \
    --docdir=/usr/share/doc/mpfr-${mpfr_v}
make
make install

cd ..
rm -rf mpfr-${mpfr_v}
touch $PROGRESS_DIR/2-mpfr
