#!/bin/bash
if [ -f $PROGRESS_DIR/1-gcc-$PASS ] ; then
	exit 0
fi
echo "building gcc pass $PASS..."
set -e
cd $MINL/sources
rm -rf gcc-${gcc_v}
tar xf gcc-${gcc_v}.tar.xz
cd gcc-${gcc_v}
if [ "$PASS" == "2" ] ; then
	cat gcc/limitx.h gcc/glimits.h gcc/limity.h > `dirname $($MINL_TGT-gcc -print-libgcc-file-name)`/include-fixed/limits.h
fi
tar xf ../mpfr-${mpfr_v}.tar.xz
mv mpfr-${mpfr_v} mpfr
tar xf ../gmp-${gmp_v}.tar.xz
mv gmp-${gmp_v} gmp
tar xf ../mpc-${mpc_v}.tar.gz
mv mpc-${mpc_v} mpc
for file in gcc/config/{linux,i386/linux{,64}}.h
do
	cp -u $file{,.orig}
	sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' -e 's@/usr@/tools@g' $file.orig > $file
	echo '#undef STANDARD_STARTFILE_PREFIX_1' >> $file
	echo '#undef STANDARD_STARTFILE_PREFIX_2' >> $file
	echo '#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"' >> $file
	echo '#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
	touch $file.orig
done
case $(uname -m) in
	x86_64)
		sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64xz
		;;
	armv7l) 
		sed -i '/k prot/agcc_cv_libc_provides_ssp=yes' gcc/configure 
		;;
esac
mkdir build
cd build
case $(uname -m) in
	x86)
		;&
	x86_64)
		if [ "$PASS" == "1" ] ; then
			../configure --prefix=/tools --target=$MINL_TGT --with-glibc-version=2.11 --with-sysroot=$MINL --with-newlib --without-headers --with-local-prefix=/tools --with-native-system-header-dir=/tools/include --disable-nls --disable-shared --disable-multilib --disable-decimal-float --disable-threads --disable-libatomic --disable-libgomp --disable-libmpx --disable-libquadmath --disable-libssp --disable-libvtv --disable-libstdcxx --enable-languages=c,c++ 
		else
			CC=$MINL_TGT-gcc CXX=$MINL_TGT-g++ AR=$MINL_TGT-ar RANLIB=$MINL_TGT-ranlib ../configure --prefix=/tools --with-local-prefix=/tools --with-native-system-header-dir=/tools/include --enable-languages=c,c++ --disable-libstdcxx-pch --disable-multilib --disable-bootstrap --disable-libgomp
		fi
		;;
	armv71)
		if [ "$PASS" == "1" ] ; then
			../configure --prefix=/tools --target=$MINL_TGT --with-glibc-version=2.11 --with-sysroot=$MINL --with-newlib --without-headers --with-local-prefix=/tools --with-native-system-header-dir=/tools/include --disable-nls --disable-shared --disable-multilib --disable-decimal-float --disable-threads --disable-libatomic --disable-libgomp --disable-libmpx --disable-libquadmath --disable-libssp --disable-libvtv --disable-libstdcxx --enable-languages=c,c++ --with-arch=$MINL_ARCH --with-float=$MINL_FLOAT --with-fpu=$MINL_FPU
		else
			CC=$MINL_TGT-gcc CXX=$MINL_TGT-g++ AR=$MINL_TGT-ar RANLIB=$MINL_TGT-ranlib ../configure --prefix=/tools --target=$MINL_TGT --with-glibc-version=2.11 --with-local-prefix=/tools --with-native-system-header-dir=/tools/include --enable-languages=c,c++ --disable-libstdcxx-pch --disable-multilib --disable-bootstrap --disable-libgomp --with-arch=$MINL_ARCH --with-float=$MINL_FLOAT --with-fpu=$MINL_FPU
		fi
		;;
esac
make 
make install 
if [ "$PASS" == "2" ] ; then
	ln -s gcc /tools/bin/cc
fi
cd $MINL/sources
rm -rf gcc-${gcc_v}
touch $PROGRESS_DIR/1-gcc-$PASS
