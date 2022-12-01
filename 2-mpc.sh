#!/bin/bash

if [ -f $PROGRESS_DIR/2-mpc ] ; then 
	exit 0
fi

echo "building mpc..."

set -e

rm -rf mpc-${mpc_v}
tar xf mpc-${mpc_v}.tar.gz
cd mpc-${mpc_v}

./configure \
    --prefix=/usr \
    --disable-static \
    --docdir=/usr/share/doc/mpc-${mpc_v}
make
make install

cd ..
rm -rf mpc-${mpc_v}
touch $PROGRESS_DIR/2-mpc
