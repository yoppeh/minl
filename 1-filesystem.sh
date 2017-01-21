#!/bin/bash
if [ -f $PROGRESS_DIR/1-filesystem ] ; then
	exit 0
fi
echo "preparing filesystem..."
if [ -e /tools ] ; then
	rm -rf /tools
fi
if [ "$ROOT_DEV" != "" ] ; then
umount $ROOT_DEV
mkfs.ext4 -F $ROOT_DEV
mount $ROOT_DEV $MINL
fi
if [ "$SWAP_DEV" != "" ] ; then
swapoff $SWAP_DEV
mkswap $SWAP_DEV
swapon $SWAP_DEV
fi
mkdir -p $MINL/tools
mkdir -p $MINL/sources
mkdir -p $MINL/boot
chmod a+wt $MINL/sources
ln -s $MINL/tools /
cp * $MINL/sources
mkdir -p $PROGRESS_DIR
sync
touch $PROGRESS_DIR/1-filesystem
