#!/bin/bash

if [ -f $PROGRESS_DIR/2-gettext-$PASS ] ; then
	exit 0
fi

echo "building gettext..."

set -e

tar xf gettext-${gettext_v}.tar.xz
cd gettext-${gettext_v}

if [ "$PASS" == "1" ] ; then
    ./configure --disable-shared
else 
    ./configure \
        --prefix=/usr \
        --disable-static \
        --docdir=/usr/share/doc/gettext-${gettext_v}
fi
make
if [ "$PASS" == "1" ] ; then
    cp gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin
else
    make install
    chmod -v 0755 /usr/lib/preloadable_libintl.so
fi

cd ..
rm -rf gettext-${gettext_v}
touch $PROGRESS_DIR/2-gettext-$PASS
