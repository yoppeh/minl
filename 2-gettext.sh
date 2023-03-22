#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-gettext-$PASS ] ; then
	exit 0
fi

echo "building gettext..."

set -e

tar xf gettext-${gettext_v}.tar.xz
cd gettext-${gettext_v}

if [ "$KEEP_STATIC_LIBS" == "0" ] ; then
disable_static="--disable-static"
else
disable_static=""
fi

if [ "$PASS" == "1" ] ; then
    ./configure --disable-shared
else 
    ./configure \
        --prefix=/usr \
        --docdir=/usr/share/doc/gettext-${gettext_v} \
        ${disable_static}
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
