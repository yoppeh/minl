#!/bin/bash
if [ -f $PROGRESS_DIR/1-tar ] ; then
	exit 0
fi
echo "building tar..."
set -e
cd $MINL/sources
rm -rf tar-${tar_v}
tar xf tar-${tar_v}.tar.xz
cd tar-${tar_v}
./configure --prefix=/tools
make
make install
cd ..
rm -rf tar-${tar_v}
touch $PROGRESS_DIR/1-tar
