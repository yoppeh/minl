
# Set this block of variables according to your system
# TARGET_DEV is the device name of the disk you are installing to. For example: /dev/sdb
# ROOT_DEV is the device name of the root partition you are installing to. For example: /dev/sdb1
# ROOT_PARTITION is the partition # of the root partition you are installing to. For example: 1
# SWAP_DEV is the device name of the swap partition you will be using. This can be blank. For example: /dev/sdb2
# KERNEL_CONFIG is the name of one of the kernel-config.xxxxxxxxx files in the minl repo. For example: kernel-config.virtualbox for a virtualbox vm kernel.
# TIMEZONE is the timezone string you want. For example: "America/Chicago"
export TARGET_DEV=
export ROOT_DEV=
export ROOT_PARTITION=
export SWAP_DEV=
export KERNEL_CONFIG=kernel-config.virtualbox
export TIMEZONE="America/Chicago"

# The remainder can be left alone
set +h
umask 022

export MINL=/mnt/minl
export LC_ALL=POSIX

export PROGRESS_DIR=/tools/progress

case $(uname -m) in
	x86)
		;&
	x86_64)
		export MINL_TGT=$(uname -m)-minl-linux-gnu
		;;
	armv7l)
		export MINL_ARCH="arm"
		export MINL_ARM_ARCH="arm7-a"
		export MINL_FLOAT="hard"
		export MINL_FPU="neon"
		export MINL_TGT=arm-minl-linux-gnueabihf
		;;
esac
