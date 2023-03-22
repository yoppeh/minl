#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-findutils ] ; then
	exit 0
fi

echo "building findutils..."

set -e

tar xf findutils-${findutils_v}.tar.xz
cd findutils-${findutils_v}

case $(uname -m) in
    i?86)
        TIME_T_32_BIT_OK=yes ./configure --prefix=/usr --localstatedir=/var/lib/locate ;;
    x86_64)
        ./configure --prefix=/usr --localstatedir=/var/lib/locate ;;
esac
make
make install

cd ..
rm -rf findutils-${findutils_v}
touch $PROGRESS_DIR/2-findutils
