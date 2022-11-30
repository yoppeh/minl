#!/tools/bin/bash

[ -z "$MINLENV" ] && exec env -i MINLENV=1 /tools/bin/bash "$0"

export FORCE_UNSAFE_CONFIGURE=1
export PATH=/bin:/usr/bin:/sbin:/tools/bin:/tools/sbin

. ./environment.sh
. ./package-versions.sh

set -e

/tools/bin/bash ./2-filesystem.sh
./2-linux-headers.sh
./2-man-pages.sh
./2-glibc.sh
./2-adjust-toolchain.sh
./2-zlib.sh
./2-file.sh
./2-binutils.sh
./2-gmp.sh
./2-mpfr.sh
./2-mpc.sh
./2-gcc.sh
./2-bzip2.sh
./2-pkg-config.sh
./2-ncurses.sh
./2-attr.sh
./2-acl.sh
./2-libcap.sh
./2-sed.sh
./2-shadow.sh
./2-psmisc.sh
./2-iana-etc.sh
./2-m4.sh
./2-bison.sh
./2-flex.sh
./2-grep.sh
./2-readline.sh
./2-bash.sh
./2-bc.sh
./2-libtool.sh
./2-gdbm.sh
./2-gperf.sh
./2-expat.sh
./2-inetutils.sh
./2-perl.sh
./2-xml-parser.sh
./2-intltool.sh
./2-autoconf.sh
./2-automake.sh
./2-xz.sh
./2-kmod.sh
./2-gettext.sh
./2-procps.sh
./2-e2fsprogs.sh
./2-coreutils.sh
./2-diffutils.sh
./2-gawk.sh
./2-findutils.sh
./2-groff.sh
./2-grub.sh
./2-less.sh
./2-gzip.sh
./2-iproute.sh
./2-kbd.sh
./2-libpipeline.sh
./2-make.sh
./2-patch.sh
./2-sysklogd.sh
./2-sysvinit.sh
./2-eudev.sh
./2-util-linux.sh
./2-mandb.sh
./2-tar.sh
./2-texinfo.sh
./2-vim.sh
./2-openssl.sh
./2-cleanup.sh
