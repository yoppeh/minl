#!/bin/bash
if [ -f $PROGRESS_DIR/2-gdbm ] ; then
	exit 0
fi
echo "building gdbm..."
set -e
tar xf gdbm-${gdbm_v}.tar.gz
cd gdbm-${gdbm_v}
./configure --prefix=/usr --disable-static --enable-libgdbm-compat
make
make install
cd ..
rm -rf gdbm-${gdbm_v}
touch $PROGRESS_DIR/2-gdbm
