#!/bin/bash
if [ -f $PROGRESS_DIR/1-linux-headers ] ; then
	exit
fi
echo "building linux headers..."
cd $MINL/sources
set -e
tar xf linux-${linux_v}.tar.xz
cd linux-${linux_v}
make mrproper
case $(uname -m) in
	x86)
		;&
	x86_64)
		make INSTALL_HDR_PATH=dest headers_install
		;;
	armv7l)
		make ARCH=${MINL_ARCH} INSTALL_HDR_PATH=dest headers_install
		;;
esac
cp -r dest/include/* /tools/include
cd $MINL/sources
rm -rf linux-${linux_v}
touch $PROGRESS_DIR/1-linux-headers
