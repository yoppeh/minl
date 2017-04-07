#!/bin/bash
if [ -f $PROGRESS_DIR/1-libcap ] ; then
	exit 0
fi
echo "building libcap..."
set -e
tar xf libcap-${libcap_v}.tar.xz
cd libcap-${libcap_v}
sed -i '/install.*STALIBNAME/d' libcap/Makefile
make PAM_CAP=no
make PAM_CAP=no RAISE_SETFCAP=no lib=lib prefix=/tools/usr install
chmod -v 755 /tools/usr/lib/libcap.so
mv /tools/usr/lib/libcap.so.* /tools/lib
ln -sf ../../lib/$(readlink /tools/usr/lib/libcap.so) /tools/usr/lib/libcap.so
cd ..
rm -rf libcap-${libcap_v}
touch $PROGRESS_DIR/1-libcap
