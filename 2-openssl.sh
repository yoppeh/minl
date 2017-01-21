#!/bin/bash
if [ -f $PROGRESS_DIR/2-openssl ] ; then
	exit 0
fi
echo "building openssl..."
set -e
set -h
tar xf openssl-${openssl_v}.tar.gz
cd openssl-${openssl_v}
./config --prefix=/usr --openssldir=/etc/ssl --libdir=/lib shared zlib-dynamic
make depend
make
make MANDIR=/usr/share/man MANSUFFIX=ssl install
install -d -m755 /usr/share/doc/openssl-${openssl_v}
cp -fr doc/* /usr/share/doc/openssl-${openssl_v}
cd ..
/bin/rm -rf openssl-${openssl_v}
touch $PROGRESS_DIR/2-openssl
