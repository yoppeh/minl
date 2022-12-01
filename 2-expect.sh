#!/bin/bash

if [ -f $PROGRESS_DIR/2-expect ] ; then
	exit 0
fi

echo "building expect..."

set -e

tar xf expect${expect_v}.tar.gz
cd expect${expect_v}

./configure \
    --prefix=/usr \
    --with-tcl=/usr/lib \
    --enable-shared \
    --mandir=/usr/share/man \
    --with-tclinclude=/usr/include
make
make install
ln -s expect${expect_v}/libexpect${expect_v}.so /usr/lib

cd ..
rm -rf expect${expect_v}
touch $PROGRESS_DIR/2-expect
