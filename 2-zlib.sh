#!/bin/bash
if [ -f $PROGRESS_DIR/2-zlib ] ; then
	exit 0
fi
echo "building zlib..."
set -e
rm -rf zlib-${zlib_v}
tar xf zlib-${zlib_v}.tar.xz
cd zlib-${zlib_v}
./configure --prefix=/usr
make
make install
mv -v /usr/lib/libz.so.* /lib
ln -sf ../../lib/$(readlink /usr/lib/libz.so) /usr/lib/libz.so
cd ..
rm -rf zlib-${zlib_v}
touch $PROGRESS_DIR/2-zlib
