#!/bin/bash

[ -z "$MINLENV" ] && exec env -i MINLENV=1 /bin/bash "$0"

export PATH=/bin:/usr/bin:/sbin:/usr/sbin

. ./environment.sh

set -e

bootscripts_v=20220723 ./3-bootscripts.sh
./3-network.sh
./3-inittab.sh
./3-sysclock.sh
./3-rc-site.sh
./3-profile.sh
./3-inputrc.sh
./3-shells.sh
./3-fstab.sh
linux_v='6.0.10' ./3-kernel.sh
#./3-bootloader.sh
blfs_bootscripts_v='20220722' ./3-blfs-bootscripts.sh
dhcpcd_v='9.4.1' ./3-dhcpcd.sh
./3-finish.sh
