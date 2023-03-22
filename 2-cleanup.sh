#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-cleanup ] ; then
	exit 0
fi

echo "cleaning up..."

set -e

rm -rf /usr/share/{info,man,doc}/*
if [ "$KEEP_STATIC_LIBS" == "0" ] ; then
find /usr/{lib,libexec} -name \*.la -delete
fi
rm -rf /tools

touch $PROGRESS_DIR/2-cleanup
