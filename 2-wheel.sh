#!/bin/bash

if [ -f $PROGRESS_DIR/2-wheel ] ; then
	exit 0
fi

echo "building wheel..."

set -e

tar xf wheel-${wheel_v}.tar.gz
cd wheel-${wheel_v}

pip3 install --no-index $PWD

cd ..
rm -rf wheel-${wheel_v}
touch $PROGRESS_DIR/2-wheel
