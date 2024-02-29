#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-flit-core ] ; then 
    exit 0
fi

echo "building flit-core..."

set -e

rm -rf flit_core-${flit_core_v}
tar xf flit_core-${flit_core_v}.tar.gz
cd flit_core-${flit_core_v}

pip3 wheel -w dist --no-build-isolation --no-deps $PWD
pip3 install --no-index --no-user --find-links dist flit_core

cd ..
rm -rf flit_core-${flit_core_v}
touch $PROGRESS_DIR/2-flit-core
