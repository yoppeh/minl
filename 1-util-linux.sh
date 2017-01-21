#!/bin/bash
if [ -f $PROGRESS_DIR/1-util-linux ] ; then
	exit 0
fi
echo "building util-linux..."
set -e
cd $MINL/sources
rm -rf util-linux-${util_linux_v}
tar xf util-linux-${util_linux_v}.tar.xz
cd util-linux-${util_linux_v}
./configure --prefix=/tools --without-python --disable-makeinstall-chown --without-cap-ng --without-udev --without-readline --without-systemdsystemunitdir PKG_CONFIG=""
make
make install
cd ..
rm -rf util-linux-${util_linux_v}
touch $PROGRESS_DIR/1-util-linux
