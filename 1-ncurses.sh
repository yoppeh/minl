#!/bin/bash

export STAGE=1

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/1-ncurses ] ; then
    exit 0
fi

echo "building ncurses..."

set -e

cd $MINL/sources
rm -rf ncurses-${ncurses_v}
tar xf ncurses-${ncurses_v}.tar.xz
cd ncurses-${ncurses_v}

sed -i s/mawk// configure

mkdir build
pushd build
../configure
make -C include
make -C progs tic
popd

./configure \
    --prefix=/usr \
    --host=$MINL_TGT \
    --build=$(./config.guess) \
    --mandir=/usr/share/man \
    --with-manpage-format=normal \
    --with-shared \
    --without-normal \
    --with-cxx-shared \
    --without-debug \
    --without-ada \
    --disable-stripping \
    --enable-widec
make
make DESTDIR=$MINL TIC_PATH=$(pwd)/build/progs/tic install
echo "INPUT(-lncursesw)" > $MINL/usr/lib/libncurses.so

cd ..
rm -rf ncurses-${ncurses_v}
touch $PROGRESS_DIR/1-ncurses
