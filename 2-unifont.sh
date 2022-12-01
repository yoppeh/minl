#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-unifont ] ; then
	exit 0
fi

echo "building unifont..."

set -e

mkdir -p /usr/share/font/unifont
gunzip -c unifont-${unifont_v}.pcf.gz /usr/share/fonts/unifont/unifont.pcf

touch $PROGRESS_DIR/2-unifont