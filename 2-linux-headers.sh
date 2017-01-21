#!/bin/bash
if [ -f $PROGRESS_DIR/2-linux-headers ] ; then
	exit 0
fi
echo "building linux headers..."
set -e
cd /sources
rm -rf linux-${linux_v}
tar xf linux-${linux_v}.tar.xz
cd linux-${linux_v}
make mrproper
make INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete
cp -r dest/include/* /usr/include
cd ..
rm -rf linux-${linux_v}
touch $PROGRESS_DIR/2-linux-headers
