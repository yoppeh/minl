#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-pkgconf ] ; then
    exit 0
fi

echo "building pkgconf..."

set -e

tar xf pkgconf-${pkgconf_v}.tar.xz
cd pkgconf-${pkgconf_v}

./configure \
    --prefix=/usr \
    --docdir=/usr/share/doc/pkgconf-${pkgconf_v} \
    --disable-static
make
make install
ln -s pkgconf /usr/bin/pkg-config
ln -s pkgconf.1 /usr/share/man/man1/pkg-config.1

cd ..
rm -rf pkgconf-${pkgconf_v}
touch $PROGRESS_DIR/2-pkgconf
