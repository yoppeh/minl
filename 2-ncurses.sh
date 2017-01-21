#!/bin/bash
if [ -f $PROGRESS_DIR/2-ncurses ] ; then
	exit 0
fi
echo "building ncurses..."
set -e
tar xf ncurses-${ncurses_v}.tar.gz
cd ncurses-${ncurses_v}
sed -i '/LIBTOOL_INSTALL/d' c++/Makefile.in
./configure --prefix=/usr --mandir=/usr/share/man --with-shared --without-debug --without-normal --enable-pc-files --enable-widec
make
make install
mv /usr/lib/libncursesw.so.6* /lib
ln -sf ../../lib/$(readlink /usr/lib/libncursesw.so) /usr/lib/libncursesw.so
for lib in ncurses form panel menu ; do
	rm -f /usr/lib/lib${lib}.so
	echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
	ln -sf ${lib}w.pc /usr/lib/pkgconfig/${lib}.pc
done
rm -f /usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
ln -sf libncurses.so /usr/lib/libcurses.so
mkdir /usr/share/doc/ncurses-${ncurses_v}
cp -R doc/* /usr/share/doc/ncurses-${ncurses_v}

cd ..
rm -rf ncurses-${ncurses_v}
touch $PROGRESS_DIR/2-ncurses
