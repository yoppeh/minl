#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-readline ] ; then
    exit 0
fi

echo "building readline..."

set -e

tar xf readline-${readline_v}.tar.gz
cd readline-${readline_v}

sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSTUFF}/c:' support/shlib-install

patch -Np1 -i ../readline-${readline_v}-upstream_fixes-3.patch

./configure \
    --prefix=/usr \
    --disable-static \
    --with-curses \
    --docdir=/usr/share/doc/readline-${readline_v} 
make SHLIB_LIBS="-lncursesw"
make SHLIB_LIBS="-lncursesw" install

cd ..
rm -rf readline-${readline_v}
touch $PROGRESS_DIR/2-readline
