#!/bin/bash
if [ -f $PROGRESS_DIR/2-gmp ] ; then
	exit 0
fi
echo "building gmp..."
set -e
rm -rf gmp-${gmp_v}
tar xf gmp-${gmp_v}.tar.xz
cd gmp-${gmp_v}
case $(uname -m) in
		x86) ABI=32 ./configure --prefix=/usr --enable-cxx --disable-static --docdir=/usr/share/doc/gmp-${gmp_v} ;;
		x86_64) ./configure --prefix=/usr --enable-cxx --disable-static --docdir=/usr/share/doc/gmp-${gmp_v} ;;
esac
make
make install
cd ..
rm -rf gmp-${gmp_v}
touch $PROGRESS_DIR/2-gmp
