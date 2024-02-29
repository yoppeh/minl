#!/bin/bash

export STAGE=2

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

./configure \
    --prefix=/usr \
    --disable-static \
    --docdir=/usr/share/doc/flex-${flex_v} 
make
make install
ln -s flex /usr/bin/lex
ln -s flex.1 /usr/share/man/man1/lex.1

cd ..
rm -rf flex-${flex_v}
touch $PROGRESS_DIR/2-flex
