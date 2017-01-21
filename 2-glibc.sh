#!/bin/bash
if [ -f $PROGRESS_DIR/2-glibc ] ; then
	exit 0
fi
echo "building glibc..."
rm -rf glibc-${glibc_v}
tar xf glibc-${glibc_v}.tar.xz
cd glibc-${glibc_v}
patch -Np1 -i ../glibc-${glibc_v}-fhs-1.patch
case $(uname -m) in
	x86) 
		ln -s ld-linux.so.2 /lib/ld-lsb.so.3 
		;;
	x86_64) 
		ln -s ../lib/ld-linux-x86-64.so.2 /lib64
		ln -s ../lib/ld-linux-x86-64.so.2 /lib64/ld-lsb-x86-64.so.3
		;;
esac
rm -rf ../glibc-build
mkdir ../glibc-build
cd ../glibc-build
../glibc-${glibc_v}/configure --prefix=/usr --enable-kernel=2.6.32 --enable-obsolete-rpc libc_cv_slibdir=/lib
make
touch /etc/ld.so.conf
make install
cp ../glibc-${glibc_v}/nscd/nscd.conf /etc/nscd.conf
mkdir -p /var/cache/nscd
mkdir -p /usr/lib/locale
mkdir -p /tools/lib/locale
localedef -i cs_CZ -f UTF-8 cs_CZ.UTF-8
localedef -i de_DE -f ISO-8859-1 de_DE
localedef -i de_DE@euro -f ISO-8859-15 de_DE@euro
localedef -i de_DE -f UTF-8 de_DE.UTF-8
localedef -i en_GB -f UTF-8 en_GB.UTF-8
localedef -i en_HK -f ISO-8859-1 en_HK
localedef -i en_PH -f ISO-8859-1 en_PH
localedef -i en_US -f ISO-8859-1 en_US
localedef -i en_US -f UTF-8 en_US.UTF-8
localedef -i es_MX -f ISO-8859-1 es_MX
localedef -i fa_IR -f UTF-8 fa_IR
localedef -i fr_FR -f ISO-8859-1 fr_FR
localedef -i fr_FR@euro -f ISO-8859-15 fr_FR@euro
localedef -i fr_FR -f UTF-8 fr_FR.UTF-8
localedef -i it_IT -f ISO-8859-1 it_IT
localedef -i it_IT -f UTF-8 it-IT.UTF-8
localedef -i ja_JP -f EUC-JP ja_JP
localedef -i ru_RU -f KOI8-R ru_RU.KOI8-R
localedef -i ru_RU -f UTF-8 ru_RU.UTF_8
localedef -i tr_TR -f UTF-8 tr_TR.UTF-8
localedef -i zh_CN -f GB18030 zh_CN.GB18030
cat > /etc/nsswitch.conf << "EOF"
# Begin /etc/nsswitch.conf
passwd: files
group: files
shadow: files
hosts: files dns
networks: files
protocols: files
services: files
ethers: files
rpc: files
# End /etc/nsswitch.conf
EOF

tar xf ../tzdata2016j.tar.gz

ZONEINFO=/usr/share/zoneinfo
mkdir -p $ZONEINFO/{posix,right}

for tz in etcetera southamerica northamerica europe africa antarctica asia australasia backward pacificnew systemv; do
	zic -L /dev/null -d $ZONEINFO -y "sh yearistype.sh" ${tz}
	zic -L /dev/null -d $ZONEINFO/posix -y "sh yearistype.sh" ${tz}
	zic -L leapseconds -d $ZONEINFO/right -y "sh yearistype.sh" ${tz}
done

cp zone.tab zone1970.tab iso3166.tab $ZONEINFO
zic -d $ZONEINFO -p $TIMEZONE
unset ZONEINFO
cd ..
rm -rf glibc-${glibc_v}
rm -rf glibc-build

cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime

cat > /etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf
/usr/local/lib
/opt/lib

# Add an include directory
include /etc/ld.so.conf.d/*.conf

EOF
mkdir -p /etc/ld.so.conf.d
touch $PROGRESS_DIR/2-glibc
