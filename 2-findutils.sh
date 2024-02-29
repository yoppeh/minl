#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-findutils ] ; then
    exit 0
fi

echo "building findutils..."

set -e

tar xf findutils-${findutils_v}.tar.xz
cd findutils-${findutils_v}

./configure --prefix=/usr --localstatedir=/var/lib/locate
make
make install

cd ..
rm -rf findutils-${findutils_v}
touch $PROGRESS_DIR/2-findutils
