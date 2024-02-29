#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-setuptools ] ; then
    exit 0
fi

echo "building setuptools..."

set -e

tar xf setuptools-${setuptools_v}.tar.gz
cd setuptools-${setuptools_v}

pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
pip3 install --no-index --find-links dist setuptools

cd ..
rm -rf setuptools-${setuptools_v}
touch $PROGRESS_DIR/2-setuptools
