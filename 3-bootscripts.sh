#!/bin/bash

if [ -f $PROGRESS_DIR/3-bootscripts ] ; then
	exit 0
fi

echo "installing bootscripts..."

set -e

tar xf lfs-bootscripts-${lfs_bootscripts_v}.tar.xz
cd lfs-bootscripts-${lfs_bootscripts_v}

make install

cd ..
rm -rf lfs-bootscripts-${lfs_bootscripts_v}
touch $PROGRESS_DIR/3-bootscripts
