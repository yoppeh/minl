#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-wheel ] ; then
	exit 0
fi

echo "building wheel..."

set -e

tar xf wheel-${wheel_v}.tar.gz
cd wheel-${wheel_v}

PYTHONPATH=src pip3 wheel -w dist --no-build-isolation --no-deps $PWD
pip3 install --no-index --find-links=dist wheel

cd ..
rm -rf wheel-${wheel_v}
touch $PROGRESS_DIR/2-wheel
