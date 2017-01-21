#!/bin/bash
if [ -f $PROGRESS_DIR/2-kbd ] ; then
	exit 0
fi
echo "building kbd..."
set -e
tar xf kbd-${kbd_v}.tar.xz
cd kbd-${kbd_v}
patch -Np1 -i ../kbd-2.0.3-backspace-1.patch
sed -i 's/\(RESIZE_ICONS_PROGS=\)yes/\1no/g' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in
PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr --disable-vlock
make
make install
cd ..
rm -rf kbd-${kbd_v}
touch $PROGRESS_DIR/2-kbd
