#!/bin/bash
if [ -f $PROGRESS_DIR/2-gperf ] ; then
	exit 0
fi
echo "building gperf..."
set -e
tar xf gperf-${gperf_v}.tar.gz
cd gperf-${gperf_v}
./configure --prefix=/usr --docdir=/usr/share/doc/gperf-${gperf_v}
make
make install
cd ..
rm -rf gperf-${gperf_v}
touch $PROGRESS_DIR/2-gperf
