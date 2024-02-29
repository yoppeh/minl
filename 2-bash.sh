#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-bash ] ; then
    exit 0
fi

echo "building bash..."

set -e

tar xf bash-${bash_v}.tar.gz
cd bash-${bash_v}

patch -Np1 -i ../bash-${bash_v}-upstream_fixes-1.patch

./configure \
    --prefix=/usr \
    --without-bash-malloc \
    --with-installed-readline \
    --docdir=/usr/share/doc/bash-${bash_v}
make
make install

cd ..
rm -rf bash-${bash_v}
touch $PROGRESS_DIR/2-bash
