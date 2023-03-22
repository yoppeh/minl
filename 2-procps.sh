#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-procps ] ; then
	exit 0
fi

echo "building procps..."

set -e

tar xf procps-ng-${procps_ng_v}.tar.xz
cd procps-ng-${procps_ng_v}

if [ "$KEEP_STATIC_LIBS" == "0" ] ; then
disable_static="--disable-static"
else
disable_static=""
fi 

./configure \
    --prefix=/usr \
    --docdir=/usr/share/doc/procps-ng-${procps_ng_v} \
    --disable-kill \
    $disable_static \
    --with-systemd
make
make install

cd ..
rm -rf procps-ng-${procps_ng_v}
touch $PROGRESS_DIR/2-procps
