#!/bin/bash
if [ -f $PROGRESS_DIR/1-binutils-$PASS ] ; then
	exit 0
fi
echo "building binutils pass $PASS..."
set -e
cd $MINL/sources
rm -rf binutils-${binutils_v}
tar xf binutils-${binutils_v}.tar.bz2
cd binutils-${binutils_v}
mkdir build
cd build
if [ "$PASS" == "1" ] ; then
	../configure --prefix=/tools --with-sysroot=$MINL --with-lib-path=/tools/lib --target=$MINL_TGT --disable-nls --disable-werror
else
	case $(uname -m) in
		x86)
			;&
		x86_64)
			CC=${MINL_TGT}-gcc AR=$MINL_TGT-ar RANLIB=$MINL_TGT-ranlib ../configure --prefix=/tools --disable-nls --disable-werror --with-lib-path=/tools/lib --with-sysroot
			;;
	esac
fi
make
if [ "$PASS" == "1" ] ; then
	case $(uname -m) in
		x86_64) 
			mkdir /tools/lib
			ln -s lib /tools/lib64
			;;
	esac
fi
make install
if [ "$PASS" == "2" ] ; then
	make -C ld clean
	make -C ld LIB_PATH=/usr/lib:/lib
	cp -v ld/ld-new /tools/bin
fi
cd $MINL/sources
rm -rf binutils-${binutils_v}
touch $PROGRESS_DIR/1-binutils-$PASS
