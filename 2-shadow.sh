#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-shadow ] ; then 
    exit 0
fi

echo "building shadow..."

set -e

tar xf shadow-${shadow_v}.tar.xz
cd shadow-${shadow_v}

sed -i 's/groups${EXEEXT} //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;
find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
find man -name Makefile.in -exec sed -i 's/passwd\.5 / /' {} \;
sed \
    -e 's:#ENCRYPT_METHOD DES:ENCRYPT_METHOD YESCRYPT:' \
    -e 's:/var/spool/mail:/var/mail:' \
    -e '/PATH=/{s@/sbin:@@;s@/bin:@@}' \
    -i etc/login.defs
touch /usr/bin/passwd

./configure \
    --sysconfdir=/etc \
    --disable-static \
    --with-{b,yes}crypt \
    --without-libbsd \
    --with-group-name-max-length=32 
make
make exec_prefix=/usr install
make -C man install-man
/usr/sbin/pwconv
/usr/sbin/grpconv
mkdir -p /etc/default
useradd -D --gid 999
echo "root:$ROOT_PASSWORD" | chpasswd

cd ..
rm -rf shadow-${shadow_v}
touch $PROGRESS_DIR/2-shadow
