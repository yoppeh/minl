#!/bin/bash
if [ -f $PROGRESS_DIR/1-file ] ; then
	exit 0
fi
echo "building file..."
set -e
cd $MINL/sources
rm -rf file-${file_v}
tar xf file-${file_v}.tar.gz
cd file-${file_v}
./configure --prefix=/tools
make
make install
cd ..
rm -rf file-${file_v}
touch $PROGRESS_DIR/1-file
