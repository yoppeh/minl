#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-mandb ] ; then
	exit 0
fi

echo "building mandb..."

set -e

tar xf man-db-${mandb_v}.tar.xz
cd man-db-${mandb_v}

./configure \
    --prefix=/usr \
    --docdir=/usr/share/doc/man-db-${mandb_v} \
    --sysconfdir=/etc \
    --disable-setuid \
    --enable-cache-owner=bin \
    --with-browser=/usr/bin/lynx \
    --with-vgrind=/usr/bin/vgrind \
    --with-grap=/usr/bin/grap 
make
make install

cd ..
rm -rf man-db-${mandb_v}
touch $PROGRESS_DIR/2-mandb
