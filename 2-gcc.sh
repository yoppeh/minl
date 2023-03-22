#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-gcc ] ; then
	exit 0
fi

echo "building gcc..."

set -e

rm -rf gcc-${gcc_v}
tar xf gcc-${gcc_v}.tar.xz
cd gcc-${gcc_v}

case $(uname -m) in
	x86_64) 
		sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64 
		;;
esac
rm -rf build
mkdir build
cd build

../configure \
    --prefix=/usr \
    LD=ld \
    --enable-languages=c,c++ \
    --enable-default-pie \
    --enable-default-ssp \
    --disable-multilib \
    --disable-bootstrap \
    --with-system-zlib
make
make install
chown -R root:root /usr/lib/gcc/$(gcc -dumpmachine)/${gcc_v}/include{,-fixed}
ln -s ../usr/bin/cpp /usr/lib
ln -sf ../../libexec/gcc/$(gcc -dumpmachine)/${gcc_v}/liblto_plugin.so /usr/lib/bfd-plugins/

mkdir -p /usr/share/gdb/auto-load/usr/lib
mv /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib

cd /sources
rm -rf gcc-${gcc_v}
touch $PROGRESS_DIR/2-gcc
