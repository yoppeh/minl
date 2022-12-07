#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-perl ] ; then
	exit 0
fi

echo "building perl..."

set -e

tar xf perl-${perl_v}.tar.xz
cd perl-${perl_v}

export BUILD_ZLIB=False
export BUILD_BZIP2=0
if [ "$PASS" == "1" ] ; then
    sh Configure -des \
        -Dprefix=/usr \
        -Dvendorprefix=/usr \
        -Dprivlib=/usr/lib/perl${perl_major_v}/${perl_mm_v}/core_perl \
        -Darchlib=/usr/lib/perl${perl_major_v}/${perl_mm_v}/core_perl \
        -Dsitelib=/usr/lib/perl${perl_major_v}/${perl_mm_v}/site_perl \
        -Dsitesearch=/usr/lib/perl${perl_major_v}/${perl_mm_v}/site_perl \
        -Dvendorlib=/usr/lib/perl${perl_major_v}/${perl_mm_v}/vendor_perl \
        -Dvendorarch=/usr/lib/perl${perl_major_v}/${perl_mm_v}/vendor_perl 
else
    sh Configure -des \
        -Dprefix=/usr \
        -Dvendorprefix=/usr \
        -Dprivlib=/usr/lib/perl${perl_major_v}/${perl_mm_v}/core_perl \
        -Darchlib=/usr/lib/perl${perl_major_v}/${perl_mm_v}/core_perl \
        -Dsitelib=/usr/lib/perl${perl_major_v}/${perl_mm_v}/site_perl \
        -Dsitesearch=/usr/lib/perl${perl_major_v}/${perl_mm_v}/site_perl \
        -Dvendorlib=/usr/lib/perl${perl_major_v}/${perl_mm_v}/vendor_perl \
        -Dvendorarch=/usr/lib/perl${perl_major_v}/${perl_mm_v}/vendor_perl \
        -Dman1dir=/usr/share/man/man1 \
        -Dman3dir=/usr/share/man/man3 \
        -Dpager="/usr/bin/less -isR" \
        -Duseshrplib \
        -Dusethreads
fi
make
make install
unset BUILD_ZLIB BUILD_BZIP2

cd ..
rm -rf perl-${perl_v}
touch $PROGRESS_DIR/2-perl
