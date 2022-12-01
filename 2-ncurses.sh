#!/bin/bash

if [ -f $PROGRESS_DIR/2-ncurses ] ; then
	exit 0
fi

echo "building ncurses..."

set -e

tar xf ncurses-${ncurses_v}.tar.gz
cd ncurses-${ncurses_v}

./configure \
    --prefix=/usr \
    --mandir=/usr/share/man \
    --with-shared \
    --without-debug \
    --without-normal \
    --with-cxx-shared \
    --enable-pc-files \
    --enable-widec \
    --with-pkg-config-libdir=/usr/lib/pkgconfig
make
make DESTDIR=$PWD/dest install
install -m755 dest/usr/lib/libncursesw.so.${ncurses_v} /usr/lib
rm dest/usr/lib/libncursesw.so.${ncurses_v}
cp -a dest/* /

for lib in ncurses form panel menu ; do
    rm -f                    /usr/lib/lib${lib}.so
    echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
    ln -sf ${lib}w.pc        /usr/lib/pkgconfig/${lib}.pc
done

rm -f                      /usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
ln -sf  libncurses.so      /usr/lib/libcurses.so

cd ..
rm -rf ncurses-${ncurses_v}
touch $PROGRESS_DIR/2-ncurses
