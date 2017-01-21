#!/bin/bash
if [ -f $PROGRESS_DIR/1-zlib ] ; then
	exit 0
fi
echo "building zlib..."
set -e
rm -rf zlib-${zlib_v}
tar xf zlib-${zlib_v}.tar.xz
cd zlib-${zlib_v}
./configure --prefix=/tools
make
make install
cd ..
rm -rf zlib-${zlib_v}
touch $PROGRESS_DIR/1-zlib
