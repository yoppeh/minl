#!/bin/bash
if [ -f $PROGRESS_DIR/2-gettext ] ; then
	exit 0
fi
echo "building gettext..."
set -e
tar xf gettext-${gettext_v}.tar.xz
cd gettext-${gettext_v}
./configure --prefix=/usr --disable-static --docdir=/usr/share/doc/gettext-${gettext_v}
make
make install
chmod -v 0755 /usr/lib/preloadable_libintl.so
cd ..
rm -rf gettext-${gettext_v}
touch $PROGRESS_DIR/2-gettext
