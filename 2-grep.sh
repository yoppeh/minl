#!/bin/bash
if [ -f $PROGRESS_DIR/2-grep ] ; then
	exit 0
fi
echo "building grep..."
set -e
tar xf grep-${grep_v}.tar.xz
cd grep-${grep_v}
./configure --prefix=/usr --bindir=/bin
make
make install
cd ..
rm -rf grep-${grep_v}
touch $PROGRESS_DIR/2-grep
