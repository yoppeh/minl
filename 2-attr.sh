#!/bin/bash
if [ -f $PROGRESS_DIR/2-attr ] ; then
	exit 0
fi
echo "building attr..."
set -e
tar xf attr-${attr_v}.src.tar.gz
cd attr-${attr_v}
sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in
sed -i -e "/SUBDIRS/s|man[25]||g" man/Makefile
./configure --prefix=/usr --bindir=/bin --disable-static
make
make install install-dev install-lib
chmod 755 /usr/lib/libattr.so
mv /usr/lib/libattr.so.* /lib
ln -sf ../../lib/$(readlink /usr/lib/libattr.so) /usr/lib/libattr.so
cd ..
rm -rf attr-${attr_v}
touch $PROGRESS_DIR/2-attr
