#!/bin/bash
if [ -f $PROGRESS_DIR/1-findutils ] ; then
	exit 0
fi
echo "building findutils..."
set -e
cd $MINL/sources
rm -rf findutils-${findutils_v}
tar xf findutils-${findutils_v}.tar.gz
cd findutils-${findutils_v}
./configure --prefix=/tools
make
make install
cd ..
rm -rf findutils-${findutils_v}
touch $PROGRESS_DIR/1-findutils
