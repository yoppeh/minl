#!/bin/bash
if [ -f $PROGRESS_DIR/2-automake ] ; then
	exit 0
fi
echo "building automake..."
set -e
tar xf automake-${automake_v}.tar.xz
cd automake-${automake_v}
sed -i 's:/\\\${:/\\\$\\{:' bin/automake.in
./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.15
make
sed -i "s:./configure:LEXLIB=/usr/lib/libfl.a &:" t/lex-{clean,depend}-cxx.sh
make install
cd ..
rm -rf automake-${automake_v}
touch $PROGRESS_DIR/2-automake
