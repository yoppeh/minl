#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-man-pages ] ; then
    exit 0
fi

echo "building man-pages..."

set -e

tar xf man-pages-${man_pages_v}.tar.xz
cd man-pages-${man_pages_v}

rm man3/crypt*
make prefix=/usr install

cd ..
rm -rf man-pages-${man_pages_v}
touch $PROGRESS_DIR/2-man-pages
