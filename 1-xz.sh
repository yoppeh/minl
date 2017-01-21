#!/bin/bash
if [ -f $PROGRESS_DIR/1-xz ] ; then
	exit 0
fi
echo "building xz..."
set -e
cd $MINL/sources
rm -rf xz-${xz_v}
tar xf xz-${xz_v}.tar.xz
cd xz-${xz_v}
./configure --prefix=/tools
make
make install
cd ..
rm -rf xz-${xz_v}
touch $PROGRESS_DIR/1-xz
