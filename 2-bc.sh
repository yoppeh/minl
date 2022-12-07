#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-bc ] ; then
	exit 0
fi

echo "building bc..."

set -e

tar xf bc-${bc_v}.tar.xz
cd bc-${bc_v}

CC=gcc ./configure --prefix=/usr -G -O3 -r
make
make install

cd ..
rm -rf bc-${bc_v}
touch $PROGRESS_DIR/2-bc
