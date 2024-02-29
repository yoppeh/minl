#!/bin/bash
#
# Stage 3 installs networking, bootscripts, bootloader and kernel. Once this
# script finishes, the system should be completely self-supporting and 
# bootable.

[ -z "$MINLENV" ] && exec env -i MINLENV=1 /bin/bash "$0"

export STAGE=3

. ./environment.sh
. ./package-versions.sh

set -e

export CFLAGS=$COMPILE_FLAGS
export CXXFLAGS=$COMPILE_FLAGS

./3-network.sh
./3-sysclock.sh
./3-profile.sh
./3-inputrc.sh
./3-shells.sh
./3-fstab.sh
./3-bootloader.sh
./3-finish.sh
