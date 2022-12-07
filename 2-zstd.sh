#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-zstd ] ; then
	exit 0
fi

echo "building zstd..."

set -e

tar xf zstd-${zstd_v}.tar.gz
cd zstd-${zstd_v}

patch -Np1 -i ../zstd-1.5.2-upstream_fixes-1.patch

make prefix=/usr
make prefix=/usr install

rm /usr/lib/libzstd.a

cd ..
rm -rf zstd-${zstd_v}
touch $PROGRESS_DIR/2-zstd
