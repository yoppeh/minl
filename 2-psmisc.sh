#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-psmisc ] ; then
    exit 0
fi

echo "building psmisc..."

set -e

tar xf psmisc-${psmisc_v}.tar.xz
cd psmisc-${psmisc_v}

./configure --prefix=/usr
make
make install

cd ..
rm -rf psmisc-${psmisc_v}
touch $PROGRESS_DIR/2-psmisc
