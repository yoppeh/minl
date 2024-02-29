#!/bin/bash

export STAGE=3

. ./environment.sh
. ./package-versions.sh

if [ -f $PROGRESS_DIR/3-bootloader ] ; then
    exit 0
fi

echo "setting up bootloader..."

set -e

if [ -d /boot/loader/entries ] ; then
    echo "title ${SYS_NAME}" > /boot/loader/entries/${SYS_NAME}.conf
    echo "linux /vmlinuz-${linux_v}-${SYS_NAME}" >> /boot/loader/entries/${SYS_NAME}.conf
    echo "options root=${ROOT_DEV} rw" >> /boot/loader/entries/${SYS_NAME}.conf
fi

touch $PROGRESS_DIR/3-bootloader
