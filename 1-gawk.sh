#!/bin/bash
if [ -f $PROGRESS_DIR/1-gawk ] ; then
	exit 0
fi
echo "building gawk..."
set -e
cd $MINL/sources
rm -rf gawk-${gawk_v}
tar xf gawk-${gawk_v}.tar.xz
cd gawk-${gawk_v}
./configure --prefix=/tools
make
make install
cd ..
rm -rf gawk-${gawk_v}
touch $PROGRESS_DIR/1-gawk
