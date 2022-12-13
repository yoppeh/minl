#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-which ] ; then
	exit 0
fi

echo "building which..."

set -e

tar xf which-${which_v}.tar.gz
cd which-${which_v}

./configure \
	--prefix=/usr
make
make install

cd ..
rm -rf which-${which_v}
touch $PROGRESS_DIR/2-which
