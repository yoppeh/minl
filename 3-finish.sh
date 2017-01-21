#!/bin/bash
if [ -f $PROGRESS_DIR/3-finish ] ; then
	exit 0
fi
echo "finishing up..."
set -e
echo "2017-01-14" > /etc/minl-release
cat > /etc/lsb-release << "EOF"
DISTRIB_ID="minl"
DISTRIB_RELEASE="2017-01-14"
DISTRIB_CODENAME=""
DISTRIB_DESCRIPTION="minimal linux"
EOF
touch $PROGRESS_DIR/3-finish
