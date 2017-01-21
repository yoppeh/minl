#!/bin/bash
if [ -f $PROGRESS_DIR/1-tcl ] ; then
	exit 0
fi
echo "building tcl..."
set -e
cd $MINL/sources
rm -rf tcl${tcl_v}
tar xf tcl-core${tcl_v}-src.tar.gz
cd tcl${tcl_v}/unix
./configure --prefix=/tools
make
make install
chmod u+w /tools/lib/libtcl8.6.so
make install-private-headers
ln -s tclsh8.6 /tools/bin/tclsh
cd $MINL/sources
rm -rf tcl${tcl_v}
touch $PROGRESS_DIR/1-tcl
