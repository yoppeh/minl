#!/bin/bash
if [ -f $PROGRESS_DIR/1-pacman ] ; then
	exit 0
fi
echo "building pacman..."
set -e
cd $MINL/sources
rm -rf pacman-${pacman_v}
tar xf pacman-${pacman_v}.tar.gz
cd pacman-${pacman_v}
./configure --prefix=/tools 
make
make install
cd ..
rm -rf pacman-${pacman_v}
touch $PROGRESS_DIR/1-pacman
