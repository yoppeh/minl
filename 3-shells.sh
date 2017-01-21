#!/bin/bash
if [ -f $PROGRESS_DIR/3-shells ] ; then
	exit 0
fi
echo "configuring shells..."
set -e
cat > /etc/shells << "EOF"
/bin/sh
/bin/bash
EOF
touch $PROGRESS_DIR/3-shells
