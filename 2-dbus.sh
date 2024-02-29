#!/bin/bash

export STAGE=2

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

./configure --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --runstatedir=/run \
    --enable-user-session \
    --disable-static \
    --disable-doxygen-docs \
    --disable-xml-docs \
    --docdir=/usr/share/doc/dbus-${dbus_v} \
    --with-system-socket=/run/dbus/system_bus_socket

make 
make install
ln -sf /etc/machine-id /var/lib/dbus

cd ..
rm -rf dbus-${dbus_v}
touch $PROGRESS_DIR/2-dbus
