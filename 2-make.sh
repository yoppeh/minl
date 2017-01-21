#!/bin/bash
if [ -f $PROGRESS_DIR/2-make ] ; then
	exit 0
fi
echo "building make..."
set -e
tar xf make-${make_v}.tar.bz2
cd make-${make_v}
./configure --prefix=/usr
make
make install
cd ..
rm -rf make-${make_v}
touch $PROGRESS_DIR/2-make
