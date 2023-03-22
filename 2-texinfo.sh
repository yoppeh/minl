#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-texinfo-$PASS ] ; then
	exit 0
fi

echo "building texinfo..."

set -e

tar xf texinfo-${texinfo_v}.tar.xz
cd texinfo-${texinfo_v}

./configure --prefix=/usr
make
make install
make TEXMF=/usr/share/texmf install-tex

cd ..
rm -rf texinfo-${texinfo_v}
touch $PROGRESS_DIR/2-texinfo-$PASS
