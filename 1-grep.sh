#!/bin/bash

if [ -f $PROGRESS_DIR/1-grep ] ; then
	exit 0
fi

echo "building grep..."

set -e

cd $MINL/sources
rm -rf grep-${grep_v}
tar xf grep-${grep_v}.tar.xz
cd grep-${grep_v}

./configure \
    --prefix=/usr \
    --host=$MINL_TGT
make
make DESTDIR=$MINL install

cd ..
rm -rf grep-${grep_v}
touch $PROGRESS_DIR/1-grep
