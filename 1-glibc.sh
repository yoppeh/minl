#!/bin/bash

export STAGE=1

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/1-glibc ] ; then
    exit 0
fi

echo "building glibc..."

set -e

cd $MINL/sources
rm -rf glibc-${glibc_v}
tar xf glibc-${glibc_v}.tar.xz
cd glibc-${glibc_v}
rm -rf build

case $(uname -m) in
    i?86) 
        ln -sf ld-linux.so.2 $MINL/lib/ld-lsb.so.3
        ;;
    x86_64) 
        ln -sf ../lib/ld-linux-x86-64.so.2 $MINL/lib64
        ln -sf ../lib/ld-linux-x86-64.so.2 $MINL/lib64/ld-lsb-x86-64.so.3
        ;;
esac

patch -Np1 -i ../glibc-${glibc_v}-fhs-1.patch

mkdir build
cd build

echo "rootsbindir=/usr/sbin" > configparms

../configure \
    --prefix=/usr \
    --host=$MINL_TGT \
    --build=$(../scripts/config.guess) \
    --enable-kernel=${linux_mm_v} \
    --with-headers=$MINL/usr/include \
    --disable-nscd \
    libc_cv_slibdir=/usr/lib

make
make DESTDIR=$MINL install
sed 'RTLDLIST=/s@/usr@@g' -i $MINL/usr/bin/ldd

cd $MINL/sources
rm -rf glibc-${glibc_v}
touch $PROGRESS_DIR/1-glibc
