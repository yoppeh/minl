#!/bin/bash
if [ -f $PROGRESS_DIR/2-bc ] ; then
	exit 0
fi
echo "building bc..."
set -e
tar xf bc-${bc_v}.tar.bz2
cd bc-${bc_v}
patch -Np1 -i ../bc-1.06.95-memory_leak-1.patch
./configure --prefix=/usr --with-readline --mandir=/usr/share/man --infodir=/usr/share/info
make
make install
cd ..
rm -rf bc-${bc_v}
touch $PROGRESS_DIR/2-bc
