#!/bin/bash

[ -z "$MINLENV" ] && exec env -i MINLENV=1 /bin/bash "$0"

export FORCE_UNSAFE_CONFIGURE=1
export PATH=/tools/bin:/tools/sbin:/bin:/usr/bin:/sbin

. ./environment.sh

# prepare target environment
./1-filesystem.sh

set -e

# stage 1

PASS=1 binutils_v='2.28' ./1-binutils.sh
PASS=1 gcc_v='6.3.0' mpfr_v='3.1.5' gmp_v='6.1.2' mpc_v='1.0.3' ./1-gcc.sh
linux_v='4.10.8' ./1-linux-headers.sh
glibc_v='2.25' ./1-glibc.sh
gcc_v='6.3.0' mpfr_v='3.1.5' gmp_v='6.1.2' mpc_v='1.0.3' ./1-libstdc++.sh
PASS=2 binutils_v='2.27' ./1-binutils.sh
PASS=2 gcc_v='6.3.0' mpfr_v='3.1.5' gmp_v='6.1.2' mpc_v='1.0.3' ./1-gcc.sh
tcl_v='8.6.6' ./1-tcl.sh
expect_v='5.45' ./1-expect.sh
dejagnu_v='1.6' ./1-dejagnu.sh
check_v='0.11.0' ./1-check.sh
ncurses_v='6.0' ./1-ncurses.sh
bash_v='4.4' ./1-bash.sh
bison_v='3.0.4' ./1-bison.sh
bzip2_v='1.0.6' ./1-bzip2.sh
coreutils_v='8.27' ./1-coreutils.sh
diffutils_v='3.5' ./1-diffutils.sh
zlib_v='1.2.11' ./1-zlib.sh
file_v='5.30' ./1-file.sh
findutils_v='4.6.0' ./1-findutils.sh
gawk_v='4.1.4' ./1-gawk.sh
gettext_v='0.19.8.1' ./1-gettext.sh
grep_v='3.0' ./1-grep.sh
gzip_v='1.8' ./1-gzip.sh
m4_v='1.4.18' ./1-m4.sh
make_v='4.2.1' ./1-make.sh
patch_v='2.7.5' ./1-patch.sh
perl_v='5.24.1' ./1-perl.sh
sed_v='4.4' ./1-sed.sh
tar_v='1.29' ./1-tar.sh
texinfo_v='6.3' ./1-texinfo.sh
util_linux_v='2.29.2' ./1-util-linux.sh
xz_v='5.2.3' ./1-xz.sh

./1-devices.sh
./1-chroot.sh

