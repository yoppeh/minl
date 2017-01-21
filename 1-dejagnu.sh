#!/bin/bash
if [ -f $PROGRESS_DIR/1-dejagnu ] ; then
	exit 0
fi
echo "building dejagnu..."
set -e
cd $MINL/sources
rm -rf dejagnu-${dejagnu_v}
tar xf dejagnu-${dejagnu_v}.tar.gz
cd dejagnu-${dejagnu_v}
./configure --prefix=/tools
make install
cd ..
rm -rf dejagnu-${dejagnu_v}
touch $PROGRESS_DIR/1-dejagnu
