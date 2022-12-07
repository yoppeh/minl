#!/bin/bash

. ./environment.sh
. ./package-versions.sh

if [ -f $PROGRESS_DIR/3-bootloader ] ; then
	exit 0
fi

echo "setting up bootloader..."

set -e

grub-install $TARGET_DEV
cat > /boot/grub/grub.cfg << EOF
# begin /boot/grub/grub.cfg
set default=0
set timeout=5
insmod ext4
set root=(hd0,$ROOT_PARTITION)
menuentry "minl" {
	linux (hd0,$ROOT_PARTITION)/boot/vmlinuz root=/dev/sda$ROOT_PARTITION ro
}
# end /boot/grub/grub.cfg
EOF

touch $PROGRESS_DIR/3-bootloader
