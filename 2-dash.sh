#!/bin/bash
if [ -f $PROGRESS_DIR/2-dash ] ; then
	exit 0
fi
echo "building dash..."
set -e
tar xf dash-${dash_v}.tar.gz
cd dash-${dash_v}
./configure --bindir=/bin --mandir=/usr/share/man
make
make install
ln -sf dash /bin/sh
cd ..
rm -rf dash-${dash_v}
touch $PROGRESS_DIR/2-dash
