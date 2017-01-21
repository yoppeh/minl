#!/bin/bash
if [ -f $PROGRESS_DIR/2-sed ] ; then
	exit 0
fi
echo "building sed..."
set -e
tar xf sed-${sed_v}.tar.xz
cd sed-${sed_v}
sed -i 's/usr/tools/' build-aux/help2man
sed -i 's/panic-tests.sh//' Makefile.in
./configure --prefix=/usr --bindir=/bin
make
make install
install -d -m755 /usr/share/doc/sed-4.3
cd ..
rm -rf sed-${sed_v}
touch $PROGRESS_DIR/2-sed
