#!/bin/bash
if [ -f $PROGRESS_DIR/2-sysvinit ] ; then
	exit 0
fi
echo "building sysvinit..."
set -e
tar xf sysvinit-${sysvinit_v}.tar.bz2
cd sysvinit-${sysvinit_v}
patch -Np1 -i ../sysvinit-2.88dsf-consolidated-1.patch
make -C src
make -C src install
cd ..
rm -rf sysvinit-${sysvinit_v}
touch $PROGRESS_DIR/2-sysvinit
