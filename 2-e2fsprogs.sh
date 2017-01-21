#!/bin/bash
if [ -f $PROGRESS_DIR/2-e2fsprogs ] ; then
	exit 0
fi
echo "building e2fsprogs..."
set -e
tar xf e2fsprogs-${e2fsprogs_v}.tar.gz
cd e2fsprogs-${e2fsprogs_v}
mkdir build
cd build
LIBS=-L/tools/lib CFLAGS=-I/tools/include PKG_CONFIG_PATH=/tools/lib/pkgconfig ../configure --prefix=/usr --bindir=/bin --with-root-prefix="" --enable-elf-shlibs --disable-libblkid --disable-libuuid --disable-uuid --disable-fsck
make
ln -sf /tools/lib/lib{blk,uu}id.so.1 lib
make install
make install-libs
chmod u+w /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a
cd ../..
rm -rf e2fsprogs-${e2fsprogs_v}
touch $PROGRESS_DIR/2-e2fsprogs
