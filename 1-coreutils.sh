#!/bin/bash
if [ -f $PROGRESS_DIR/1-coreutils ] ; then
	exit 0
fi
echo "building coreutils..."
set -e
cd $MINL/sources
rm -rf coreutils-${coreutils_v}
tar xf coreutils-${coreutils_v}.tar.xz
cd coreutils-${coreutils_v}
./configure --prefix=/tools --enable-install-program=hostname
make
make install
cd ..
rm -rf coreutils-${coreutils_v}
touch $PROGRESS_DIR/1-coreutils
