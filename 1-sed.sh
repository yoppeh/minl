#!/bin/bash
if [ -f $PROGRESS_DIR/1-sed ] ; then
	exit 0
fi
echo "building sed..."
set -e
cd $MINL/sources
rm -rf sed-${sed_v}
tar xf sed-${sed_v}.tar.xz
cd sed-${sed_v}
./configure --prefix=/tools
make
make install
cd ..
rm -rf sed-${sed_v}
touch $PROGRESS_DIR/1-sed
