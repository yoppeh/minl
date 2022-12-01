#!/bin/bash

if [ -f $PROGRESS_DIR/2-gawk ] ; then
	exit 0
fi

echo "building gawk..."

set -e

tar xf gawk-${gawk_v}.tar.xz
cd gawk-${gawk_v}

sed -i 's/extras//' Makefile.in
./configure --prefix=/usr
make
make install

cd ..
rm -rf gawk-${gawk_v}
touch $PROGRESS_DIR/2-gawk
