#!/bin/bash

if [ -f $PROGRESS_DIR/1-bash ] ; then
	exit 0
fi

echo "building bash..."

set -e

cd $MINL/sources
rm -rf bash-${bash_v}
tar xf bash-${bash_v}.tar.gz
cd bash-${bash_v}

./configure \
    --prefix=/usr \
    --build=$(support/config.guess) \
    --host=$MINL_TGT \
    --without-bash-malloc
make
make DESTDIR=$MINL install

ln -s bash $MINL/bin/sh

cd ..
rm -rf bash-${bash_v}
touch $PROGRESS_DIR/1-bash
