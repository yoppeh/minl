#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-systemd ] ; then
    exit 0
fi

echo "building systemd..."

set -e

tar xf systemd-${systemd_v}.tar.gz
cd systemd-${systemd_v}

sed -i -e 's/GROUP="render"/GROUP="video"/' \
    -e 's/GROUP="sgx", //' rules.d/50-udev-default.rules.in

patch -Np1 -i ../systemd-255-upstream_fixes-1.patch

mkdir -p build
cd build

meson --prefix=/usr                 \
    --buildtype=release           \
    -Ddefault-dnssec=no           \
    -Dfirstboot=false             \
    -Dinstall-tests=false         \
    -Dldconfig=false              \
    -Dsysusers=false              \
    -Drpmmacrosdir=no             \
    -Dhomed=false                 \
    -Duserdb=false                \
    -Dman=disabled                \
    -Dmode=release                \
    -Dpamconfdir=no               \
    -Ddev-kvm-mode=0660           \
    -Dnobody-group=nogroup        \
    -Dsysupdate=disabled          \
    -Dukify=disabled              \
    -Ddocdir=/usr/share/doc/systemd-${systemd_v} \
    ..

ninja
ninja install
tar -xf ../../systemd-man-pages-${systemd_v}.tar.xz --no-same-owner --strip-components=1 -C /usr/share/man
systemd-machine-id-setup
systemctl preset-all

cd ..
rm -rf systemd-${systemd_v}
touch $PROGRESS_DIR/2-systemd
