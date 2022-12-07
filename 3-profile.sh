#!/bin/bash

. ./environment.sh
. ./package-versions.sh

if [ -f $PROGRESS_DIR/3-profile ] ; then
	exit 0
fi

echo "configuring bash profile..."

set -e

cat > /etc/profile << "EOF"
export LANG="en_US.iso88591"
EOF

touch $PROGRESS_DIR/3-profile
