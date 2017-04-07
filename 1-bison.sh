#!/bin/bash
if [ -f $PROGRESS_DIR/1-bison ] ; then
	exit 0
fi
echo "building bison..."
set -e
cd $MINL/sources
rm -rf bison-${bison_v}
tar xf bison-${bison_v}.tar.gz
cd bison-${bison_v}
./configure --prefix=/tools
make
make install
cd ..
rm -rf bison-${bison_v}
touch $PROGRESS_DIR/1-bison
