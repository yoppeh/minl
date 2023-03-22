#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-dbus ] ; then
	exit 0
fi

echo "building dbus..."

set -e

tar xf dbus-${dbus_v}.tar.xz
cd dbus-${dbus_v}

if [ "$KEEP_STATIC_LIBS" == "0" ] ; then
disable_static="--disable-static"
else
disable_static=""
fi

./configure --prefix=/usr \
            --sysconfdir=/etc \
            --localstatedir=/var \
            --runstatedir=/run \
            --disable-doxygen-docs \
            --disable-xml-docs \
            --docdir=/usr/share/doc/dbus-${dbus_v} \
            $disable_static \
            --with-system-socket=/run/dbus/system_bus_socket

make 
make install
ln -sfv /etc/machine-id /var/lib/dbus

cd ..
rm -rf dbus-${dbus_v}
touch $PROGRESS_DIR/2-dbus
