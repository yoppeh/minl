#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-automake ] ; then
	exit 0
fi

echo "building automake..."

set -e

tar xf automake-${automake_v}.tar.xz
cd automake-${automake_v}

./configure --prefix=/usr --docdir=/usr/share/doc/automake-${automake_v}
make
make install

cd ..
rm -rf automake-${automake_v}
touch $PROGRESS_DIR/2-automake
