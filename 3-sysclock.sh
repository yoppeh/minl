#!/bin/bash

export STAGE=3

. ./environment.sh
. ./package-versions.sh

if [ -f $PROGRESS_DIR/3-sysclock ] ; then
    exit 0
fi

echo "configuring system clock..."

set -e

cat > /etc/adjtime << "EOF"
0.0 0 0.0
0
UTC
EOF

touch $PROGRESS_DIR/3-sysclock
