#!/bin/bash

. ./environment.sh
. ./package-versions.sh

if [ -f $PROGRESS_DIR/3-blfs-bootscripts ] ; then
	exit 0
fi

echo "installing blfs bootscripts..."

set -e

tar xf blfs-bootscripts-${blfs_bootscripts_v}.tar.xz
cd blfs-bootscripts-${blfs_bootscripts_v}

make install-service-dhcpcd

cd ..
rm -rf blfs-bootscripts-${blfs_bootscripts_v}
touch $PROGRESS_DIR/3-blfs-bootscripts
