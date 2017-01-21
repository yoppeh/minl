#!/bin/bash
if [ -f $PROGRESS_DIR/2-psmisc ] ; then
	exit 0
fi
echo "building psmisc..."
set -e
tar xf psmisc-${psmisc_v}.tar.gz
cd psmisc-${psmisc_v}
./configure --prefix=/usr
make
make install
mv /usr/bin/fuser /bin
mv /usr/bin/killall /bin
cd ..
rm -rf psmisc-${psmisc_v}
touch $PROGRESS_DIR/2-psmisc
