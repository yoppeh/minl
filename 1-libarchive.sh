#!/bin/bash
if [ -f $PROGRESS_DIR/1-libarchive ] ; then
	exit 0
fi
echo "building libarchive..."
set -e
cd $MINL/sources
rm -rf libarchive-${libarchive_v}
tar xf libarchive-${libarchive_v}.tar.gz
cd libarchive-${libarchive_v}
./configure --prefix=/tools  --without-xml2 --disable-shared
make
make install
cd ..
rm -rf libarchive-${libarchive_v}
touch $PROGRESS_DIR/1-libarchive
