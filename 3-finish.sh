#!/bin/bash

export STAGE=3

. ./environment.sh
. ./package-versions.sh

if [ -f $PROGRESS_DIR/3-finish ] ; then
    exit 0
fi

echo "finishing up..."

set -e

echo "2024-02-29" > /etc/${SYS_NAME}-release

cat > /etc/lsb-release << "EOF"
DISTRIB_ID=${SYS_NAME}
DISTRIB_RELEASE="2024-02-29"
DISTRIB_CODENAME=""
DISTRIB_DESCRIPTION="minimal linux"
EOF

save_usrlib="$(cd /usr/lib; ls ld-linux*[^g])
    libc.so.6
    libthread_db.so.1
    libquadmath.so.0.0.0
    libstdc++.so.6.0.30
    libitm.so.1.0.0
    libatomic.so.1.2.0"

cd /usr/lib

for LIB in $save_usrlib; do
    objcopy --only-keep-debug $LIB $LIB.dbg
    cp $LIB /tmp/$LIB
    strip --strip-unneeded /tmp/$LIB
    objcopy --add-gnu-debuglink=$LIB.dbg /tmp/$LIB
    install -vm755 /tmp/$LIB /usr/lib
    rm /tmp/$LIB
done

online_usrbin="bash find strip"
online_usrlib="libbfd-2.40.so
    libhistory.so.8.2
    libncursesw.so.6.4
    libm.so.6
    libreadline.so.8.2
    libz.so.${zlib_v}
    $(cd /usr/lib; find libnss*.so* -type f)"

for BIN in $online_usrbin; do
    cp /usr/bin/$BIN /tmp/$BIN
    strip --strip-unneeded /tmp/$BIN
    install -vm755 /tmp/$BIN /usr/bin
    rm /tmp/$BIN
done

for LIB in $online_usrlib; do
    cp /usr/lib/$LIB /tmp/$LIB
    strip --strip-unneeded /tmp/$LIB
    install -vm755 /tmp/$LIB /usr/lib
    rm /tmp/$LIB
done

#for i in $(find /usr/lib -type f -name \*.so* ! -name \*dbg) \
#         $(find /usr/lib -type f -name \*.a)                 \
#         $(find /usr/{bin,sbin,libexec} -type f); do
#    case "$online_usrbin $online_usrlib $save_usrlib" in
#        *$(basename $i)* )
#            ;;
#        * ) strip --strip-unneeded $i
#            ;;
#    esac
#done

unset BIN LIB save_usrlib online_usrbin online_usrlib

rm -rf /tmp/*

find /usr/lib /usr/libexec -name \*.la -delete
find /usr -depth -name $(uname -m)-${SYS_NAME}-linux-gnu\* | xargs rm -rf

touch $PROGRESS_DIR/3-finish
