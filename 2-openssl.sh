#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-openssl ] ; then
	exit 0
fi

echo "building openssl..."

set -e
set -h

tar xf openssl-${openssl_v}.tar.gz
cd openssl-${openssl_v}

./config \
    --prefix=/usr \
    --openssldir=/etc/ssl \
    --libdir=lib \
    shared \
    zlib-dynamic
make
sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
make MANSUFFIX=ssl install
mv /usr/share/doc/openssl /usr/share/doc/openssl-${openssl_v}

cd ..
/bin/rm -rf openssl-${openssl_v}
touch $PROGRESS_DIR/2-openssl
