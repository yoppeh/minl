#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-attr ] ; then
	exit 0
fi

echo "building attr..."

set -e

tar xf attr-${attr_v}.tar.gz
cd attr-${attr_v}

./configure \
    --prefix=/usr \
    --disable-static \
    --sysconfdir=/etc \
    --docdir=/usr/share/doc/attr-${attr_v}
make
make install

cd ..
rm -rf attr-${attr_v}
touch $PROGRESS_DIR/2-attr
