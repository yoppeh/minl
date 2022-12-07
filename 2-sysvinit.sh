#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-sysvinit ] ; then
	exit 0
fi

echo "building sysvinit..."

set -e

tar xf sysvinit-${sysvinit_v}.tar.xz
cd sysvinit-${sysvinit_v}

patch -Np1 -i ../sysvinit-3.04-consolidated-1.patch
make
make install

cd ..
rm -rf sysvinit-${sysvinit_v}
touch $PROGRESS_DIR/2-sysvinit
