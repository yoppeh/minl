#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-mandoc ] ; then
	exit 0
fi

echo "building mandoc..."

set -e

tar xf mandoc-${mandoc_v}.tar.gz
cd mandoc-${mandoc_v}

./configure
make mandoc
install -m755 mandoc /usr/bin
install -m644 mandoc.1 /usr/share/man/man1

cd ..
rm -rf mandoc-${mandoc_v}
touch $PROGRESS_DIR/2-mandoc
