#!/bin/bash
if [ -f $PROGRESS_DIR/2-libcap ] ; then
	exit 0
fi
echo "building libcap..."
set -e
tar xf libcap-${libcap_v}.tar.xz
cd libcap-${libcap_v}
sed -i '/install.*STALIBNAME/d' libcap/Makefile
make
make RAISE_SETFCAP=no lib=lib prefix=/usr install
chmod -v 755 /usr/lib/libcap.so
mv /usr/lib/libcap.so.* /lib
ln -sf ../../lib/$(readlink /usr/lib/libcap.so) /usr/lib/libcap.so
cd ..
rm -rf libcap-${libcap_v}
touch $PROGRESS_DIR/2-libcap
