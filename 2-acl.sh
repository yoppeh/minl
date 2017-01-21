#!/bin/bash
if [ -f $PROGRESS_DIR/2-acl ] ; then
	exit 0
fi
echo "building acl..."
set -e
tar xf acl-${acl_v}.src.tar.gz
cd acl-${acl_v}
sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in
sed -i "s:| sed.*::g" test/{sbits-restore,cp,misc}.test
sed -i -e "/TABS-1;/a if (x > (TABS-1)) x = (TABS-1);" libacl/__acl_to_any_text.c
./configure --prefix=/usr --bindir=/bin --disable-static --libexecdir=/usr/lib
make
make install install-dev install-lib
chmod 755 /usr/lib/libacl.so
mv /usr/lib/libacl.so.* /lib
ln -sf ../../lib/$(readlink /usr/lib/libacl.so) /usr/lib/libacl.so
cd ..
rm -rf acl-${acl_v}
touch $PROGRESS_DIR/2-acl
