#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-bison ] ; then
	exit 0
fi

echo "building bison..."

set -e

tar xf bison-${bison_v}.tar.xz
cd bison-${bison_v}

./configure --prefix=/usr --docdir=/usr/share/doc/bison-${bison_v}
make
make install

cd ..
rm -rf bison-${bison_v}
touch $PROGRESS_DIR/2-bison
