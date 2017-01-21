#!/bin/bash

if [ -f $PROGRESS_DIR/1-devices ] ; then
	exit 0
fi
echo "generating devices..."
mkdir -p $MINL/{dev,proc,sys,run}
mknod -m 600 $MINL/dev/console c 5 1
mknod -m 666 $MINL/dev/null c 1 3
mount --bind /dev $MINL/dev
mount -t devpts devpts $MINL/dev/pts -o gid=5,mode=620
mount -t proc proc $MINL/proc
mount -t sysfs sysfs $MINL/sys
mount -t tmpfs tmpfs $MINL/run

if [ -h $MINL/dev/shm ] ; then
	mkdir -p $MINL/$(readlink $MINL/dev/shm)
fi

touch $PROGRESS_DIR/1-devices
