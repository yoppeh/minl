#!/bin/bash

if [ -f $PROGRESS_DIR/2-tcl ] ; then
	exit 0
fi

echo "building tcl..."

set -e

tar xf tcl${tcl_v}-src.tar.gz
cd tcl${tcl_v}
tar xf ../tcl${tcl_v}-html.tar.gz --strip-components=1

SRCDIR=$(pwd)
cd unix
./configure \
    --prefix=/usr \
    --mandir=/usr/share/man
make
sed -e "s|$SRCDIR/unix|/usr/lib|" \
    -e "s|$SRCDIR|/usr/include|"  \
    -i tclConfig.sh
sed -e "s|$SRCDIR/unix/pkgs/tdbc1.1.3|/usr/lib/tdbc1.1.3|" \
    -e "s|$SRCDIR/pkgs/tdbc1.1.3/generic|/usr/include|"    \
    -e "s|$SRCDIR/pkgs/tdbc1.1.3/library|/usr/lib/tcl8.6|" \
    -e "s|$SRCDIR/pkgs/tdbc1.1.3|/usr/include|"            \
    -i pkgs/tdbc1.1.3/tdbcConfig.sh
sed -e "s|$SRCDIR/unix/pkgs/itcl4.2.2|/usr/lib/itcl4.2.2|" \
    -e "s|$SRCDIR/pkgs/itcl4.2.2/generic|/usr/include|"    \
    -e "s|$SRCDIR/pkgs/itcl4.2.2|/usr/include|"            \
    -i pkgs/itcl4.2.2/itclConfig.sh

unset SRCDIR

make install

chmod u+w /usr/lib/libtcl${tcl_mm_v}.so
make install-private-headers
ln -sf tclsh${tcl_mm_v} /usr/bin/tclsh
mv /usr/share/man/man3/{Thread,Tcl_Thread}.3

cd ..
rm -rf tcl${tcl_v}
touch $PROGRESS_DIR/2-tcl
