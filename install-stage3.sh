#!/bin/bash
#
# Stage 3 installs networking, bootscripts, bootloader and kernel. Once this
# script finishes, the system should be completely self-supporting and 
# bootable.

[ -z "$MINLENV" ] && exec env -i MINLENV=1 /bin/bash "$0"

export PATH=/bin:/usr/bin:/sbin:/usr/sbin

. ./environment.sh
. ./package-versions.sh

set -e

./3-bootscripts.sh
./3-network.sh
./3-inittab.sh
./3-sysclock.sh
./3-rc-site.sh
./3-profile.sh
./3-inputrc.sh
./3-shells.sh
./3-fstab.sh
./3-kernel.sh
#./3-bootloader.sh
./3-blfs-bootscripts.sh
./3-finish.sh