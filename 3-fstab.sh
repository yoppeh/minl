#!/bin/bash
if [ -f $PROGRESS_DIR/3-fstab ] ; then
	exit 0
fi
echo "configuring fstab..."
set -e
cat > /etc/fstab << EOF
# Begin /etc/fstab

# file system  mount-point  type     options             dump  fsck
#                                                              order

$ROOT_DEV      /            ext4     defaults            1     1
$SWAP_DEV      swap         swap     pri=1               0     0
proc           /proc        proc     nosuid,noexec,nodev 0     0
tmpfs          /run         tmpfs    defaults            0     0

# End /etc/fstab
EOF
touch $PROGRESS_DIR/3-fstab
