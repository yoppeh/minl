#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-markupsafe ] ; then
	exit 0
fi

echo "building markupsafe..."

set -e

tar xf MarkupSafe-${markupsafe_v}.tar.gz
cd MarkupSafe-${markupsafe_v}

pip3 wheel -w dist --no-build-isolation --no-deps $PWD
pip3 install --no-index --no-user --find-links dist Markupsafe

cd ..
rm -rf MarkupSafe-${markupsafe_v}
touch $PROGRESS_DIR/2-markupsafe
