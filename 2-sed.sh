#!/bin/bash

if [ -f $PROGRESS_DIR/2-sed ] ; then
	exit 0
fi

echo "building sed..."

set -e

tar xf sed-${sed_v}.tar.xz
cd sed-${sed_v}

./configure --prefix=/usr
make
make install

cd ..
rm -rf sed-${sed_v}
touch $PROGRESS_DIR/2-sed
