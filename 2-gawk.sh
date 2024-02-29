#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-gawk ] ; then
    exit 0
fi

echo "building gawk..."

set -e

tar xf gawk-${gawk_v}.tar.xz
cd gawk-${gawk_v}

sed -i 's/extras//' Makefile.in
./configure --prefix=/usr
make
rm -f /usr/bin/gawk-${gawk_v}
make install
ln -s gawk.1 /usr/share/man/man1/awk.1

cd ..
rm -rf gawk-${gawk_v}
touch $PROGRESS_DIR/2-gawk
