#!/bin/bash
if [ -f $PROGRESS_DIR/1-perl ] ; then 
	exit 0
fi
echo "building perl..."
set -e
cd $MINL/sources
rm -rf perl-${perl_v}
tar xf perl-${perl_v}.tar.bz2
cd perl-${perl_v}
sh Configure -des -Dprefix=/tools -Dlibs=-lm
make
cp perl cpan/podlators/scripts/pod2man /tools/bin
mkdir -p /tools/lib/perl5/${perl_v}
cp -R lib/* /tools/lib/perl5/${perl_v}
cd ..
rm -rf perl-${perl_v}
touch $PROGRESS_DIR/1-perl
