#!/bin/bash
if [ -f $PROGRESS_DIR/2-readline ] ; then
	exit 0
fi
echo "building readline..."
set -e
tar xf readline-${readline_v}.tar.gz
cd readline-${readline_v}
sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSTUFF}/c:' support/shlib-install
./configure --prefix=/usr --disable-static --docdir=/usr/share/doc/readline-${readline_v}
make SHLIB_LIBS=-lncurses
make SHLIB_LIBS=-lncurses install
mv /usr/lib/lib{readline,history}.so.* /lib
ln -sf ../../lib/$(readlink /usr/lib/libreadline.so) /usr/lib/libreadline.so
ln -sf ../../lib/$(readlink /usr/lib/libhistory.so) /usr/lib/libhistory.so
cd ..
rm -rf readline-${readline_v}
touch $PROGRESS_DIR/2-readline
