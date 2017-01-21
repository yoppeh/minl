#!/bin/bash
if [ -f $PROGRESS_DIR/1-texinfo ] ; then
	exit 0
fi
echo "building texinfo..."
set -e
cd $MINL/sources
rm -rf texinfo-${texinfo_v}
tar xf texinfo-${texinfo_v}.tar.xz
cd texinfo-${texinfo_v}
./configure --prefix=/tools
make
make install
cd $MINL/sources
rm -rf texinfo-${texinfo_v}
touch $PROGRESS_DIR/1-texinfo
