#!/bin/bash
if [ -f $PROGRESS_DIR/2-xz ] ; then
	exit 0
fi
echo "building xz..."
set -e
tar xf xz-${xz_v}.tar.xz
cd xz-${xz_v}
./configure --prefix=/usr --disable-static --docdir=/usr/share/doc/xz-${xz_v}
make
make install
mv /usr/bin/{lzma,unlzma,lzcat,xz,unxz,xzcat} /bin
mv /usr/lib/liblzma.so.* /lib
ln -sf ../../lib/$(readlink /usr/lib/liblzma.so) /usr/lib/liblzma.so
cd ..
rm -rf xz-${xz_v}
touch $PROGRESS_DIR/2-xz
