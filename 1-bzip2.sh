#!/bin/bash
if [ -f $PROGRESS_DIR/1-bzip2 ] ; then
	exit 0
fi
echo "building bzip2..."
set -e
cd $MINL/sources
rm -rf bzip2-${bzip2_v}
tar xf bzip2-${bzip2_v}.tar.gz
cd bzip2-${bzip2_v}
make
make PREFIX=/tools install
cd ..
rm -rf bzip2-${bzip2_v}
touch $PROGRESS_DIR/1-bzip2
