#!/bin/bash

if [ -f $PROGRESS_DIR/2-cleanup ] ; then
	exit 0
fi

echo "cleaning up..."

set -e

rm -rf /usr/share/{info,man,doc}/*
find /usr/{lib,libexec} -name \*.la -delete
rm -rf /tools

touch $PROGRESS_DIR/2-cleanup
