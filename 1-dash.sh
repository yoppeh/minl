#!/bin/bash
if [ -f $PROGRESS_DIR/1-dash ] ; then
	exit 0
fi
echo "building dash..."
set -e
cd $MINL/sources
rm -rf dash-${dash_v}
tar xf dash-${dash_v}.tar.gz
cd dash-${dash_v}
./configure --bindir=/tools/bin --mandir=/tools/usr/share/man
make
make install
ln -sf dash /tools/bin/sh
cd ..
rm -rf dash-${dash_v}
touch $PROGRESS_DIR/1-dash
