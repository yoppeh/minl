#!/bin/bash
if [ -f $PROGRESS_DIR/1-ncurses ] ; then
	exit 0
fi
echo "building ncurses..."
set -e
cd $MINL/sources
rm -rf ncurses-${ncurses_v}
tar xf ncurses-${ncurses_v}.tar.gz
cd ncurses-${ncurses_v}
sed -i s/mawk// configure
./configure --prefix=/tools --with-shared --without-debug --without-ada --enable-widec --enable-overwrite
make
make install
cd ..
rm -rf ncurses-${ncurses_v}
touch $PROGRESS_DIR/1-ncurses
