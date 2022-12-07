#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-iproute ] ; then
	exit 0
fi

echo "building iproute..."

set -e

tar xf iproute2-${iproute2_v}.tar.xz
cd iproute2-${iproute2_v}

sed -i /ARPD/d Makefile
rm -f man/man8/arpd.8
make NETNS_RUN_DIR=/run/netns
make SBINDIR=/usr/sbin install

cd ..
rm -rf iproute2-${iproute2_v}
touch $PROGRESS_DIR/2-iproute
