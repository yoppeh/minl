#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-groff ] ; then
	exit 0
fi

echo "building groff..."

set -e

tar xf groff-${groff_v}.tar.gz
cd groff-${groff_v}

PAGE="letter" ./configure --prefix=/usr
make
make install

cd ..
rm -rf groff-${groff_v}
touch $PROGRESS_DIR/2-groff
