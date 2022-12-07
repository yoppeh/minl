#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/1-gcc-$PASS ] ; then
	exit 0
fi

echo "building gcc pass $PASS..."

set -e
cd $MINL/sources
rm -rf gcc-${gcc_v}
tar xf gcc-${gcc_v}.tar.xz
cd gcc-${gcc_v}

tar xf ../mpfr-${mpfr_v}.tar.xz
mv mpfr-${mpfr_v} mpfr
tar xf ../gmp-${gmp_v}.tar.xz
mv gmp-${gmp_v} gmp
tar xf ../mpc-${mpc_v}.tar.gz
mv mpc-${mpc_v} mpc

case $(uname -m) in
	x86_64)
		sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
		;;
esac

if [ "$PASS" == "2" ] ; then
    sed '/thread_header =/s/@.*@/gthr-posix.h/' -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in
fi

mkdir build
cd build

if [ "$PASS" == "1" ] ; then
    ../configure \
        --target=$MINL_TGT \
        --prefix=$MINL/tools \
        --with-glibc-version=${glibc_v} \
        --with-sysroot=$MINL \
        --with-newlib \
        --without-headers \
        --disable-nls \
        --disable-shared \
        --disable-multilib \
        --disable-decimal-float \
        --disable-threads \
        --disable-libatomic \
        --disable-libgomp \
        --disable-libquadmath \
        --disable-libssp \
        --disable-libvtv \
        --disable-libstdcxx \
        --enable-languages=c,c++
else
    ../configure \
        --build=$(../config.guess) \
        --host=$MINL_TGT \
        --target=$MINL_TGT \
        LDFLAGS_FOR_TARGET=-L$PWD/$MINL_TGT/libgcc \
        --prefix=/usr \
        --with-build-sysroot=$MINL \
        --enable-initfini-array \
        --disable-nls \
        --disable-multilib \
        --disable-decimal-float \
        --disable-libatomic \
        --disable-libgomp \
        --disable-libquadmath \
        --disable-libssp \
        --disable-libvtv \
        --enable-languages=c,c++
fi
make 
if [ "$PASS" == "1" ] ; then
    make install
    cd ..
    cat gcc/limitx.h gcc/glimits.h gcc/limity.h > `dirname $($MINL_TGT-gcc -print-libgcc-file-name)`/install-tools/include/limits.h
else
    make DESTDIR=$MINL install
	ln -s gcc $MINL/usr/bin/cc
fi

cd $MINL/sources
rm -rf gcc-${gcc_v}
touch $PROGRESS_DIR/1-gcc-$PASS
