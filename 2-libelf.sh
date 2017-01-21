#!/bin/bash
if [ -f $PROGRESS_DIR/2-libelf ] ; then
	exit 0
fi
echo "building libelf..."
set -e
tar xf libelf-${libelf_v}.tar.gz
cd libelf-${libelf_v}
./configure --prefix=/usr
make
make install
cd ..
rm -rf libelf-${libelf_v}
touch $PROGRESS_DIR/2-libelf
