#!/bin/bash

export STAGE=1

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/1-linux-headers ] ; then
    exit
fi

echo "building linux headers..."

set -e

cd $MINL/sources
rm -rf linux-${linux_v}
tar xf linux-${linux_v}.tar.xz
cd linux-${linux_v}
make mrproper
make headers
find usr/include -type f ! -name '*.h' -delete
cp -r usr/include $MINL/usr

cd $MINL/sources
rm -rf linux-${linux_v}
touch $PROGRESS_DIR/1-linux-headers
