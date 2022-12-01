#!/bin/bash

if [ -f $PROGRESS_DIR/2-texinfo-$PASS ] ; then
	exit 0
fi

echo "building texinfo..."

set -e

tar xf texinfo-${texinfo_v}.tar.xz
cd texinfo-${texinfo_v}

./configure --prefix=/usr
make
make install

cd ..
rm -rf texinfo-${texinfo_v}
touch $PROGRESS_DIR/2-texinfo-$PASS
