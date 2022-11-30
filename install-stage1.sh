#!/bin/bash

[ -z "$MINLENV" ] && exec env -i MINLENV=1 /bin/bash "$0"

export FORCE_UNSAFE_CONFIGURE=1
export PATH=/tools/bin:/tools/sbin:/bin:/usr/bin:/sbin

. ./environment.sh
. ./package_versions.sh

# prepare target environment
./1-filesystem.sh

set -e

# stage 1

PASS=1 ./1-binutils.sh
PASS=1 ./1-gcc.sh
./1-linux-headers.sh
./1-glibc.sh
./1-libstdc++.sh
PASS=2 ./1-binutils.sh
PASS=2 ./1-gcc.sh
./1-tcl.sh
./1-expect.sh
./1-dejagnu.sh
./1-m4.sh
./1-ncurses.sh
./1-bash.sh
./1-bison.sh
./1-bzip2.sh
./1-coreutils.sh
./1-diffutils.sh
./1-file.sh
./1-findutils.sh
./1-gawk.sh
./1-gettext.sh
./1-grep.sh
./1-gzip.sh
./1-make.sh
./1-patch.sh
./1-perl.sh
./1-sed.sh
./1-tar.sh
./1-texinfo.sh
./1-util-linux.sh
./1-xz.sh

./1-check.sh
./1-zlib.sh
./1-libcap.sh

./1-devices.sh
./1-chroot.sh

