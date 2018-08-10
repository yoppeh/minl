#!/bin/bash
if [ -f $PROGRESS_DIR/1-gcc-$PASS ] ; then
	exit 0
fi
echo "building libstdc++..."
set -e
cd $MINL/sources
rm -rf gcc-${gcc_v}
tar xf gcc-${gcc_v}.tar.xz
cd gcc-${gcc_v}
mkdir build
cd build
../libstdc++-v3/configure --host=${MINL_TGT} --prefix=/tools --disable-multilib --disable-nls --disable-libstdcxx-threads --disable-libstdcxx-pch --with-gxx-include-dir=/tools/${MINL_TGT}/include/c++/${gcc_v}
make
make install
cd $MINL/sources
rm -rf gcc-${gcc_v}
touch $PROGRESS_DIR/1-gcc-$PASS
