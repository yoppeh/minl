#!/bin/bash
if [ -f $PROGRESS_DIR/2-gcc ] ; then
	exit 0
fi
echo "building gcc..."
set -e
rm -rf gcc-${gcc_v}
tar xf gcc-${gcc_v}.tar.bz2
cd gcc-${gcc_v}
case $(uname -m) in
	x86_64) 
		sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64 
		;;
esac
rm -rf build
mkdir build
cd build
SED=sed 
../configure --prefix=/usr --enable-languages=c,c++ --disable-multilib --disable-bootstrap --with-system-zlib
make
make install
ln -s ../usr/bin/cpp /lib
ln -sv gcc /usr/bin/cc
install -v -dm755 /usr/lib/bfd-plugins
ln -sf ../../libexec/gcc/$(gcc -dumpmachine)/${gcc_v}/liblto_plugin.so /usr/lib/bfd-plugins/
mkdir -p /usr/share/gdb/auto-load/usr/lib
mv /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
cd /sources
rm -rf gcc-${gcc_v}
touch $PROGRESS_DIR/2-gcc
