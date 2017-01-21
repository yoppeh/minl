#!/bin/bash
if [ -f $PROGRESS_DIR/1-gzip ] ; then
	exit 0
fi
echo "building gzip..."
set -e
cd $MINL/sources
rm -rf gzip-${gzip_v}
tar xf gzip-${gzip_v}.tar.xz
cd gzip-${gzip_v}
./configure --prefix=/tools
make
make install
cd ..
rm -rf gzip-${gzip_v}
touch $PROGRESS_DIR/1-gzip
