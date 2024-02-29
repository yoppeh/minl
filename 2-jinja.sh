#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-jinja2 ] ; then
    exit 0
fi

echo "building jinja2..."

set -e

tar xf Jinja2-${jinja2_v}.tar.gz
cd Jinja2-${jinja2_v}

pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
pip3 install --no-index --no-user --find-links dist Jinja2

cd ..
rm -rf Jinja2-${jinja2_v}
touch $PROGRESS_DIR/2-jinja2
