#!/bin/bash
if [ -f $PROGRESS_DIR/3-sysclock ] ; then
	exit 0
fi
echo "configuring system clock..."
set -e
cat > /etc/sysconfig/clock << "EOF"
UTC=1
CLOCKPARAMS=
EOF
touch $PROGRESS_DIR/3-sysclock
