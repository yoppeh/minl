#!/bin/bash
if [ -f $PROGRESS_DIR/2-perl ] ; then
	exit 0
fi
echo "building perl..."
set -e
tar xf perl-${perl_v}.tar.bz2
cd perl-${perl_v}
echo "127.0.0.1 localhost $(hostname)" > /etc/hosts
export BUILD_ZLIB=False
export BUILD_BZIP2=0
sh Configure -des -Dprefix=/usr -Dvendorprefix=/usr -Dman1dir=/usr/share/man/man1 -Dman3dir=/usr/share/man/man3 -Dpager="/usr/bin/less -iSR" -Duseshrplib
make
make install
unset BUILD_ZLIB BUILD_BZIP2
cd ..
rm -rf perl-${perl_v}
touch $PROGRESS_DIR/2-perl
