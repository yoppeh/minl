#!/bin/bash

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
sed -i \
    -e 's:#ENCRYPT_METHOD DES:ENCRYPT_METHOD SHA512:' \
    -e 's@#\(SHA_CRYPT_..._ROUNDS 5000\)@\100@' \
    -e 's:/var/spool/mail:/var/mail:' \
    -e '/PATH=/{s@/sbin:@@;s@/bin:@@}' \
    etc/login.defs
touch /usr/bin/passwd

if [ "$KEEP_STATIC_LIBS" == "0" ] ; then
disable_static="--disable-static"
else
disable_static=""
fi

./configure \
    --sysconfdir=/etc \
    --with-group-name-max-length=32 \
    $disable_static
make
make exec_prefix=/usr install
make -C man install-man
/usr/sbin/pwconv
/usr/sbin/grpconv
passwd root

cd ..
rm -rf shadow-${shadow_v}
touch $PROGRESS_DIR/2-shadow
