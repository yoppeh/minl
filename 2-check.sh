#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-check ] ; then
	exit 0
fi

echo "building check..."

set -e

tar xf check-${check_v}.tar.gz
cd check-${check_v}

if [ "$KEEP_STATIC_LIBS" == "0" ] ; then
disable_static="--disable-static"
else
disable_static=""
fi

./configure \
    --prefix=/usr \
    $disable_static 
make
make docdir=/usr/share/doc/check-${check_v} install

cd ..
rm -rf check-${check_v}
touch $PROGRESS_DIR/2-check
