#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-gdbm ] ; then
	exit 0
fi

echo "building gdbm..."

set -e

tar xf gdbm-${gdbm_v}.tar.gz
cd gdbm-${gdbm_v}

if [ "$KEEP_STATIC_LIBS" == "0" ] ; then
disable_static="--disable-static"
else
disable_static=""
fi

./configure \
    --prefix=/usr \
    $disable_static \
    --enable-libgdbm-compat
make
make install

cd ..
rm -rf gdbm-${gdbm_v}
touch $PROGRESS_DIR/2-gdbm
