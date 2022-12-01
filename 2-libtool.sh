#!/bin/bash

if [ -f $PROGRESS_DIR/2-libtool ] ; then
	exit 0
fi

echo "building libtool..."

set -e

tar xf libtool-${libtool_v}.tar.xz
cd libtool-${libtool_v}

./configure --prefix=/usr
make
make install

rm -f /usr/lib/libltdl.a

cd ..
rm -rf libtool-${libtool_v}
touch $PROGRESS_DIR/2-libtool
