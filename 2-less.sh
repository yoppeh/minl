#!/bin/bash

if [ -f $PROGRESS_DIR/2-less ] ; then
	exit 0
fi

echo "building less..."

set -e

tar xf less-${less_v}.tar.gz
cd less-${less_v}

./configure --prefix=/usr --sysconfdir=/etc
make
make install

cd ..
rm -rf less-${less_v}
touch $PROGRESS_DIR/2-less
