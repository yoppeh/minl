#!/bin/bash
if [ -f $PROGRESS_DIR/1-check ] ; then
	exit 0
fi
echo "building check..."
set -e
cd $MINL/sources
rm -rf check-${check_v}
tar xf check-${check_v}.tar.gz
cd check-${check_v}
PKG_CONFIG= ./configure --prefix=/tools
make
make install
cd ..
rm -rf check-${check_v}
touch $PROGRESS_DIR/1-check
