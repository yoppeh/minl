#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-dejagnu ] ; then
	exit 0
fi

echo "building dejagnu..."

set -e

tar xf dejagnu-${dejagnu_v}.tar.gz
cd dejagnu-${dejagnu_v}
mkdir build
cd build

../configure \
    --prefix=/usr
makeinfo --html --no-split -o doc/dejagnu.html ../doc/dejagnu.texi
makeinfo --plaintext -o doc/dejagnu.txt ../doc/dejagnu.texi

make install
install -dm755 /usr/share/doc/dejagnu-${dejagnu_v}
install -m644 doc/dejagnu.{html,txt} /usr/share/doc/dejagnu-${dejagnu_v}

cd ..
rm -rf dejagnu-${dejagnu_v}
touch $PROGRESS_DIR/2-dejagnu
