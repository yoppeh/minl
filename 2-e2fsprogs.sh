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

../configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --enable-elf-shlibs \
    --disable-libblkid \
    --disable-libuuid \
    --disable-uuidd \
    --disable-fsck
make
make install
rm -f /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a
gunzip /usr/share/info/libext2fs.info.gz
install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info

cd ../..
rm -rf e2fsprogs-${e2fsprogs_v}
touch $PROGRESS_DIR/2-e2fsprogs
