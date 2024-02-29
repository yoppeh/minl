#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-bzip2 ] ; then
    exit 0
fi

echo "building bzip2..."

set -e

tar xf bzip2-${bzip2_v}.tar.gz
cd bzip2-${bzip2_v}

patch -Np1 -i ../bzip2-${bzip2_v}-install_docs-1.patch
sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile
sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile

make -f Makefile-libbz2_so
make clean
make
make PREFIX=/usr install

cp -a libbz2.so.* /usr/lib
ln -s libbz2.so.1.0.8 /usr/lib/libbz2.so

cp bzip2-shared /usr/bin/bzip2
for i in /usr/bin/{bzcat,bunzip2} ; do
    ln -sf bzip2 $i
done

rm -f /usr/lib/libbz2.a

cd ..
rm -rf bzip2-${bzip2_v}
touch $PROGRESS_DIR/2-bzip2
