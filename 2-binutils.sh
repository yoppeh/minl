#!/bin/bash
if [ -f $PROGRESS_DIR/2-binutils ] ; then
	exit 0
fi
echo "building binutils..."
set -e
rm -rf binutils-${binutils_v}
tar xf binutils-${binutils_v}.tar.bz2
rm -rf binutils-build
mkdir binutils-build
cd binutils-build
../binutils-${binutils_v}/configure --prefix=/usr --enable-shared --enable-plugins --disable-werror --with-system-zlib
make tooldir=/usr
make tooldir=/usr install
cd ..
rm -rf binutils-${binutils_v}
rm -rf binutils-build
touch $PROGRESS_DIR/2-binutils
