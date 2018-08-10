#!/bin/bash
if [ -f $PROGRESS_DIR/1-make ] ; then
	exit 0
fi
echo "building make..."
set -e
cd $MINL/sources
rm -rf make-${make_v}
tar xf make-${make_v}.tar.bz2
cd make-${make_v}
sed -i '211,217 d; 219,229 d; 232 d' glob/glob.c
./configure --prefix=/tools --without-guile
make
make install
cd ..
rm -rf make-${make_v}
touch $PROGRESS_DIR/1-make
