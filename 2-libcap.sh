#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-libcap ] ; then
	exit 0
fi

echo "building libcap..."

set -e

tar xf libcap-${libcap_v}.tar.xz
cd libcap-${libcap_v}

sed -i '/install -m.*STA/d' libcap/Makefile
make prefix=/usr lib=lib
make prefix=/usr lib=lib install

cd ..
rm -rf libcap-${libcap_v}
touch $PROGRESS_DIR/2-libcap
