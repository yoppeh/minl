#!/bin/bash

if [ -f $PROGRESS_DIR/2-check ] ; then
	exit 0
fi

echo "building check..."

set -e

tar xf check-${check_v}.tar.gz
cd check-${check_v}

./configure \
    --prefix=/usr \
    --disable-static
make
make docdir=/usr/share/doc/check-${check_v} install

cd ..
rm -rf check-${check_v}
touch $PROGRESS_DIR/2-check
