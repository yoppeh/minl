#!/bin/bash
if [ -f $PROGRESS_DIR/2-inetutils ] ; then
	exit 0
fi
echo "building inetutils..."
set -e
tar xf inetutils-${inetutils_v}.tar.xz
cd inetutils-${inetutils_v}
./configure --prefix=/usr --localstatedir=/var --disable-logger --disable-whois --disable-rcp --disable-rexec --disable-rlogin --disable-rsh --disable-servers
make
make install
mv /usr/bin/{hostname,ping,ping6,traceroute} /bin
mv /usr/bin/ifconfig /sbin
cd ..
rm -rf inetutils-${inetutils_v}
touch $PROGRESS_DIR/2-inetutils
