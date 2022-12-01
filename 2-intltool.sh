#!/bin/bash

if [ -f $PROGRESS_DIR/2-intltool ] ; then
	exit 0
fi

echo "building intltool..."

set -e

tar xf intltool-${intltool_v}.tar.gz
cd intltool-${intltool_v}

sed -i 's:\\\${:\\\$\\{:' intltool-update.in
./configure --prefix=/usr
make
make install
install -Dm644 doc/I18N-HOWTO /usr/share/doc/intltool-${intltool_v}/I18N-HOWTO

cd ..
rm -rf intltool-${intltool_v}
touch $PROGRESS_DIR/2-intltool
