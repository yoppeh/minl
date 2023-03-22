#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-freetype ] ; then
	exit 0
fi

echo "building freetype..."

set -e

tar xf freetype-${freetype_v}.tar.xz
cd freetype-${freetype_v}

sed -ri "s:.*(AUX_MODULES.*valid):\1:" modules.cfg

sed -r "s:.*(#.*SUBPIXEL_RENDERING) .*:\1:" \
    -i include/freetype/config/ftoption.h

./configure \
	--prefix=/usr \
	--enable-freetype-config \
if [ "$KEEP_STATIC_LIBS" == "0" ] ; then
	--disable-static \
fi
	--without-harfbuzz 
make
make install

cd ..
rm -rf freetype-${freetype_v}
touch $PROGRESS_DIR/2-freetype
