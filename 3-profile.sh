#!/bin/bash

. ./environment.sh
. ./package-versions.sh

if [ -f $PROGRESS_DIR/3-profile ] ; then
	exit 0
fi

echo "configuring bash profile..."

set -e

cat > /etc/vconsole << "EOF"
KEYMAP=${KEYMAP}
EOF

cat > /etc/locale.conf << "EOF"
LANG=${LOCALE}
EOF

touch $PROGRESS_DIR/3-profile
