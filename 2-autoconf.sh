#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-autoconf ] ; then
	exit 0
fi

echo "building autoconf..."

set -e

tar xf autoconf-${autoconf_v}.tar.xz
cd autoconf-${autoconf_v}

./configure --prefix=/usr
make
make install

cd ..
rm -rf autoconf-${autoconf_v}
touch $PROGRESS_DIR/2-autoconf
