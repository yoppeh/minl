#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-kbd ] ; then
    exit 0
fi

echo "building kbd..."

set -e

tar xf kbd-${kbd_v}.tar.xz
cd kbd-${kbd_v}

patch -Np1 -i ../kbd-${kbd_v}-backspace-1.patch
sed -i '/RESIZEICONS_PROGS=/s/yes/no/' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in
./configure --prefix=/usr --disable-vlock
make
make install

cd ..
rm -rf kbd-${kbd_v}
touch $PROGRESS_DIR/2-kbd
