#!/bin/bash
if [ -f $PROGRESS_DIR/3-cleanup ] ; then
	exit 0
fi
echo "cleaning up..."
set -e
touch $PROGRESS_DIR/3-cleanup
