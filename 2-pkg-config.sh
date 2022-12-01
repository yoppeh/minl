#!/bin/bash

if [ -f $PROGRESS_DIR/2-pkg-config ] ; then
	exit 0
fi

echo "building pkg-config..."

set -e

tar xf pkg-config-${pkg_config_v}.tar.gz
cd pkg-config-${pkg_config_v}

./configure \
    --prefix=/usr \
    --with-internal-glib \
    --disable-host-tool \
    --docdir=/usr/share/doc/pkg-config-${pkg_config_v}
make
make install

cd ..
rm -rf pkg-config-${pkg_config_v}
touch $PROGRESS_DIR/2-pkg-config
