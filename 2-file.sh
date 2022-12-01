#!/bin/bash

if [ -f $PROGRESS_DIR/2-file ] ; then
	exit 0
fi

echo "building file..."

set -e

rm -rf file-${file_v}
tar xf file-${file_v}.tar.gz
cd file-${file_v}

./configure --prefix=/usr
make
make install

cd ..
rm -rf file-${file_v}
touch $PROGRESS_DIR/2-file
