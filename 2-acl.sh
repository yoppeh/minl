#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-acl ] ; then
	exit 0
fi

echo "building acl..."

set -e

tar xf acl-${acl_v}.tar.xz
cd acl-${acl_v}

if [ "$KEEP_STATIC_LIBS" == "0" ] ; then
disable_static="--disable-static"
else
disable_static=""
fi

./configure \
    --prefix=/usr \
    $disable_static \
    --docdir=/usr/share/doc/acl-${acl_v}
make
make install

cd ..
rm -rf acl-${acl_v}
touch $PROGRESS_DIR/2-acl
