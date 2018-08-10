#!/bin/bash
if [ -f $PROGRESS_DIR/1-glibc ] ; then
	exit 0
fi
echo "building glibc..."
set -e
cd $MINL/sources
rm -rf glibc-${glibc_v}
tar xf glibc-${glibc_v}.tar.xz
cd glibc-${glibc_v}
mkdir build
cd build
../configure --prefix=/tools --host=$MINL_TGT --target=$MINL_TGT --build=$(../scripts/config.guess) --enable-kernel=3.2 --with-headers=/tools/include libc_cv_forced_unwind=yes libc_cv_c_cleanup=yes
make -j1
make install
cd $MINL/sources
rm -rf glibc-${glibc_v}
touch $PROGRESS_DIR/1-glibc
