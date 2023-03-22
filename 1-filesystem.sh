#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/1-filesystem ] ; then
	exit 0
fi

echo "preparing filesystem..."

if [ -e /tools ] ; then
	rm -rf /tools
fi
if [ -e $MINL/boot ] ; then
    umount $MINL/boot
    rm -rf $MINL/boot
fi
if [ -e $MINL ] ; then
    umount $MINL
    rm -rf $MINL
fi

mkdir -p $MINL

if [ "$ROOT_DEV" != "" ] ; then
    umount --recursive $ROOT_DEV
    if [ "$FMT_ROOT" == "1" ] ; then
        mkfs.ext4 -L root -F $ROOT_DEV
    fi
    mount $ROOT_DEV $MINL
fi

if [ "$SWAP_DEV" != "" ] ; then
    swapoff $SWAP_DEV
    if [ "$FMT_BOOT" == "1" ] ; then
        mkswap -L swap $SWAP_DEV
    fi
    swapon $SWAP_DEV
fi

mkdir $MINL/boot

if [ "$BOOT_DEV" != "" ] ; then
    if [ "$FMT_BOOT" == "1" ] ; then
        mkfs.fat -n boot $BOOT_DEV
    fi
    mount $BOOT_DEV $MINL/boot
fi

mkdir -p $MINL/{etc,var} $MINL/usr/{bin,lib,sbin}

for i in bin lib sbin ; do
    ln -s usr/$i $MINL/$i
done

case $(uname -m) in
    x86_64) mkdir -p $MINL/lib64 ;;
esac

mkdir -p $PROGRESS_DIR
mkdir -p $MINL/sources
mkdir -p $MINL/tools
mkdir -p $MINL/boot/minl
ln -s $MINL/tools /tools
cp -R . $MINL/sources

touch $PROGRESS_DIR/1-filesystem
