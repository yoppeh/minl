#!/bin/bash

if [ -f $PROGRESS_DIR/2-iana-etc ] ; then
	exit 0
fi

echo "building iana-etc..."

set -e

tar xf iana-etc-${iana_etc_v}.tar.gz
cd iana-etc-${iana_etc_v}

cp services protocols /etc

cd ..
rm -rf iana-etc-${iana_etc_v}
touch $PROGRESS_DIR/2-iana-etc
