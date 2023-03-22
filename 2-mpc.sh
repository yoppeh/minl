#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-mpc ] ; then 
	exit 0
fi

echo "building mpc..."

set -e

rm -rf mpc-${mpc_v}
tar xf mpc-${mpc_v}.tar.gz
cd mpc-${mpc_v}

if [ "$KEEP_STATIC_LIBS" == "0" ] ; then
disable_static="--disable-static"
else
disable_static=""
fi

./configure \
    --prefix=/usr \
	$disable_static \
    --docdir=/usr/share/doc/mpc-${mpc_v}
make
make install

cd ..
rm -rf mpc-${mpc_v}
touch $PROGRESS_DIR/2-mpc
