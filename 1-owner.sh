#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/1-owner ] ; then
	exit 0
fi

echo "fixing ownership..."

set -e

chown -R root:root $MINL/{usr,lib,var,etc,bin,sbin,tools}
case $(uname -m) in
    x86_64) chown -R root:root $MINL/lib64 ;;
esac

touch $PROGRESS_DIR/1-owner
