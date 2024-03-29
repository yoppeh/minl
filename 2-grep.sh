#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-grep ] ; then
    exit 0
fi

echo "building grep..."

set -e

tar xf grep-${grep_v}.tar.xz
cd grep-${grep_v}

sed -i "s/echo/#echo/" src/egrep.sh
./configure --prefix=/usr
make
make install

cd ..
rm -rf grep-${grep_v}
touch $PROGRESS_DIR/2-grep
