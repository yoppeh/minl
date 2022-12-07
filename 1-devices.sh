#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/1-devices ] ; then
	exit 0
fi

echo "generating devices..."

mkdir -p $MINL/{dev,proc,sys,run}
mount --bind /dev $MINL/dev
mount --bind /dev/pts $MINL/dev/pts
mount -t proc proc $MINL/proc
mount -t sysfs sysfs $MINL/sys
mount -t tmpfs tmpfs $MINL/run

if [ -h $MINL/dev/shm ] ; then
	mkdir -p $MINL/$(readlink $MINL/dev/shm)
fi

touch $PROGRESS_DIR/1-devices
