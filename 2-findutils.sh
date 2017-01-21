#!/bin/bash
if [ -f $PROGRESS_DIR/2-findutils ] ; then
	exit 0
fi
echo "building findutils..."
set -e
tar xf findutils-${findutils_v}.tar.gz
cd findutils-${findutils_v}
./configure --prefix=/usr --localstatedir=/var/lib/locate
make
make install
mv /usr/bin/find /bin
sed -i 's|find:=${BINDIR}|find:=/bin|' /usr/bin/updatedb
cd ..
rm -rf findutils-${findutils_v}
touch $PROGRESS_DIR/2-findutils
