#!/bin/bash
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
cp bzip2-shared /bin/bzip2
cp -a libbz2.so* /lib
ln -s ../../lib/libbz2.so.1.0 /usr/lib/libbz2.so
rm /usr/bin/{bunzip2,bzcat,bzip2}
ln -s bzip2 /bin/bunzip2
ln -s bzip2 /bin/bzcat
cd ..
rm -rf bzip2-${bzip2_v}
touch $PROGRESS_DIR/2-bzip2
