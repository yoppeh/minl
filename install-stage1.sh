#!/bin/bash

[ -z "$MINLENV" ] && exec env -i MINLENV=1 /bin/bash "$0"

export FORCE_UNSAFE_CONFIGURE=1
export PATH=/tools/bin:/tools/sbin:/bin:/usr/bin:/sbin

. ./environment.sh

# prepare target environment
./1-filesystem.sh

set -e

# stage 1

PASS=1 binutils_v='2.39' ./1-binutils.sh
PASS=1 gcc_v='12.2.0' mpfr_v='4.1.0' gmp_v='6.2.1' mpc_v='1.2.1' ./1-gcc.sh
linux_v='6.0.10' ./1-linux-headers.sh
glibc_v='2.36' ./1-glibc.sh
gcc_v='12.2.0' mpfr_v='4.1.0' gmp_v='6.2.1' mpc_v='1.2.1' ./1-libstdc++.sh
PASS=2 binutils_v='2.39' ./1-binutils.sh
PASS=2 gcc_v='12.2.0' mpfr_v='4.1.0' gmp_v='6.2.1' mpc_v='1.2.1' ./1-gcc.sh
tcl_v='8.6.12' ./1-tcl.sh
expect_v='5.45.4' ./1-expect.sh
dejagnu_v='1.6.3' ./1-dejagnu.sh
m4_v='1.4.19' ./1-m4.sh
ncurses_v='6.3' ./1-ncurses.sh
bash_v='5.1.16' ./1-bash.sh
bison_v='3.8.2' ./1-bison.sh
bzip2_v='1.0.8' ./1-bzip2.sh
coreutils_v='9.1' ./1-coreutils.sh
diffutils_v='3.8' ./1-diffutils.sh
file_v='5.42' ./1-file.sh
findutils_v='4.9.0' ./1-findutils.sh
gawk_v='5.1.1' ./1-gawk.sh
gettext_v='0.21' ./1-gettext.sh
grep_v='3.7' ./1-grep.sh
gzip_v='1.12' ./1-gzip.sh
make_v='4.3' ./1-make.sh
patch_v='2.7.6' ./1-patch.sh
perl_v='5.36.0' ./1-perl.sh
sed_v='4.8' ./1-sed.sh
tar_v='1.34' ./1-tar.sh
texinfo_v='6.8' ./1-texinfo.sh
util_linux_v='2.38.1' ./1-util-linux.sh
xz_v='5.2.6' ./1-xz.sh

check_v='0.15.2' ./1-check.sh
zlib_v='1.2.12' ./1-zlib.sh
libcap_v='2.65' ./1-libcap.sh
fakeroot_v='1.23' ./1-fakeroot.sh
libarchive_v='3.3.2' ./1-libarchive.sh
pacman_v='5.1.1' ./1-pacman.sh

./1-devices.sh
./1-chroot.sh

