#!/bin/bash
if [ -f $PROGRESS_DIR/2-cleanup ] ; then
	exit 0
fi
echo "cleaning up..."
set -e

rm -rf /tmp/*
rm /usr/lib/lib{bfd,opcodes}.a
rm /usr/lib/libbz2.a
rm /usr/lib/lib{com_err,e2p,ext2fs,ss}.a
rm /usr/lib/libltdl.a
rm /usr/lib/libfl.a
rm /usr/lib/libz.a
touch $PROGRESS_DIR/2-cleanup
