#!/bin/bash
if [ -f $PROGRESS_DIR/2-iana-etc ] ; then
	exit 0
fi
echo "building iana-etc..."
set -e
tar xf iana-etc-${iana_etc_v}.tar.bz2
cd iana-etc-${iana_etc_v}
make
make install
cd ..
rm -rf iana-etc-${iana_etc_v}
touch $PROGRESS_DIR/2-iana-etc
