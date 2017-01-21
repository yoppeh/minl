#!/bin/bash
if [ -f $PROGRESS_DIR/2-libpipeline ] ; then
	exit 0
fi
echo "building libpipeline..."
set -e
tar xf libpipeline-${libpipeline_v}.tar.gz
cd libpipeline-${libpipeline_v}
PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr
make
make install
cd ..
rm -rf libpipeline-${libpipeline_v}
touch $PROGRESS_DIR/2-libpipeline
