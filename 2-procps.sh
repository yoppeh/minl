#!/bin/bash

export STAGE=2

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

./configure \
    --prefix=/usr \
    --docdir=/usr/share/doc/procps-ng-${procps_ng_v} \
    --disable-static \
    --disable-kill \
    --with-systemd
make src_w_LDADD='$(LDADD) -lsystemd'
make install

cd ..
rm -rf procps-ng-${procps_ng_v}
touch $PROGRESS_DIR/2-procps
