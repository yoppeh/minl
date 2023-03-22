#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-diffutils ] ; then
	exit 0
fi

echo "building diffutils..."

set -e

tar xf diffutils-${diffutils_v}.tar.xz
cd diffutils-${diffutils_v}

./configure \
    --prefix=/usr 
make
make install

cd ..
rm -rf diffutils-${diffutils_v}
touch $PROGRESS_DIR/2-diffutils
