#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-flex ] ; then
	exit 0
fi

echo "building flex..."

set -e

tar xf flex-${flex_v}.tar.gz
cd flex-${flex_v}

if [ "$KEEP_STATIC_LIBS" == "0" ] ; then
disable_static="--disable-static"
else
disable_static=""
fi

./configure \
    --prefix=/usr \
    $disable_static \
    --docdir=/usr/share/doc/flex-${flex_v} 
make
make install
ln -s flex /usr/bin/lex

cd ..
rm -rf flex-${flex_v}
touch $PROGRESS_DIR/2-flex
