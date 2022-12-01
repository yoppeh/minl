#!/bin/bash

if [ -f $PROGRESS_DIR/2-libelf ] ; then
	exit 0
fi

echo "building libelf..."

set -e

tar xf elfutils-${elfutils_v}.tar.bz2
cd elfutils-${elfutils_v}

./configure \
    --prefix=/usr \
    --disable-debuginfod \
    --enable-libdebuginfod=dummy
make
make -C libelf install
install -m644 config/libelf.pc /usr/lib/pkgconfig
rm /usr/lib/libelf.a

cd ..
rm -rf elfutils-${elfutils_v}
touch $PROGRESS_DIR/2-libelf
