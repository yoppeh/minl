#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-coreutils ] ; then
	exit 0
fi

echo "building coreutils..."

set -e
set -h

tar xf coreutils-${coreutils_v}.tar.xz
cd coreutils-${coreutils_v}

patch -Np1 -i ../coreutils-9.1-i18n-1.patch
autoreconf -fiv
FORCE_UNSAFE_CONFIGURE=1 ./configure \
    --prefix=/usr \
    --enable-no-install-program=kill,uptime
make
make install
mv /usr/bin/chroot /usr/sbin
mv /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/' /usr/share/man/man8/chroot.8

cd ..
/bin/rm -rf coreutils-${coreutils_v}
touch $PROGRESS_DIR/2-coreutils
