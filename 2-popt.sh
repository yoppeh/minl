#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-popt ] ; then
	exit 0
fi

echo "building popt..."

set -e

tar xf popt-${popt_v}.tar.gz
cd popt-${popt_v}

./configure \
    --prefix=/usr \
    --disable-static
make
make install

cd ..
rm -rf popt-${popt_v}
touch $PROGRESS_DIR/2-popt
