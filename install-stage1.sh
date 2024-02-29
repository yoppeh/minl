#!/bin/bash
#
# Stage 1 sets up a build system on the target that is isolated from the host.
# The final step of stage 1 is to enter a chroot in the target from which stage
# 2 can be built.

[ -z "$MINLENV" ] && exec env -i MINLENV=1 /bin/bash "$0"

export STAGE=1

. ./environment.sh
. ./package-versions.sh

# prepare target environment
./1-filesystem.sh

set -e

# stage 1

PASS=1 ./1-binutils.sh
PASS=1 ./1-gcc.sh
./1-linux-headers.sh
./1-glibc.sh
./1-libstdc++.sh
./1-m4.sh
./1-ncurses.sh
./1-bash.sh
./1-coreutils.sh
./1-diffutils.sh
./1-file.sh
./1-findutils.sh
./1-gawk.sh
./1-grep.sh
./1-gzip.sh
./1-make.sh
./1-patch.sh
./1-sed.sh
./1-tar.sh
./1-xz.sh
PASS=2 ./1-binutils.sh
PASS=2 ./1-gcc.sh
./1-owner.sh
./1-devices.sh
./1-chroot.sh
