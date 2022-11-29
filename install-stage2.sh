#!/tools/bin/bash

[ -z "$MINLENV" ] && exec env -i MINLENV=1 /tools/bin/bash "$0"

export FORCE_UNSAFE_CONFIGURE=1
export PATH=/bin:/usr/bin:/sbin:/tools/bin:/tools/sbin

. ./environment.sh

set -e

/tools/bin/bash ./2-filesystem.sh
linux_v='6.0.10' ./2-linux-headers.sh
man_pages_v='5.13' ./2-man-pages.sh
glibc_v='2.36' ./2-glibc.sh
./2-adjust-toolchain.sh
zlib_v='1.2.12' ./2-zlib.sh
file_v='5.42' ./2-file.sh
binutils_v='2.39' ./2-binutils.sh
gmp_v='6.2.1' ./2-gmp.sh
mpfr_v='4.1.0' ./2-mpfr.sh
mpc_v='1.2.1' ./2-mpc.sh
gcc_v='12.2.0' ./2-gcc.sh
bzip2_v='1.0.8' ./2-bzip2.sh
pkg_config_v='0.29.2' ./2-pkg-config.sh
ncurses_v='6.3' ./2-ncurses.sh
attr_v='2.5.1' ./2-attr.sh
acl_v='2.3.1' ./2-acl.sh
libcap_v='2.65' ./2-libcap.sh
sed_v='4.8' ./2-sed.sh
shadow_v='4.12.2' ./2-shadow.sh
psmisc_v='23.5' ./2-psmisc.sh
iana_etc_v='20220812' ./2-iana-etc.sh
m4_v='1.4.19' ./2-m4.sh
bison_v='3.8.2' ./2-bison.sh
flex_v='2.6.4' ./2-flex.sh
grep_v='3.7' ./2-grep.sh
readline_v='8.1.2' ./2-readline.sh
bash_v='5.1.16' ./2-bash.sh
bc_v='6.0.1' ./2-bc.sh
libtool_v='2.4.7' ./2-libtool.sh
gdbm_v='1.23' ./2-gdbm.sh
gperf_v='3.1' ./2-gperf.sh
expat_v='2.4.8' ./2-expat.sh
inetutils_v='2.3' ./2-inetutils.sh
perl_v='5.36.0' ./2-perl.sh
xml_parser_v='2.46' ./2-xml-parser.sh
intltool_v='0.51.0' ./2-intltool.sh
autoconf_v='2.71' ./2-autoconf.sh
automake_v='1.16.5' ./2-automake.sh
xz_v='5.2.6' ./2-xz.sh
kmod_v='30' ./2-kmod.sh
gettext_v='0.21' ./2-gettext.sh
procps_v='4.0.0' ./2-procps.sh
e2fsprogs_v='1.46.5' ./2-e2fsprogs.sh
coreutils_v='9.1' ./2-coreutils.sh
diffutils_v='3.8' ./2-diffutils.sh
gawk_v='5.1.1' ./2-gawk.sh
findutils_v='4.9.0' ./2-findutils.sh
groff_v='1.22.4' ./2-groff.sh
grub_v='2.06' ./2-grub.sh
less_v='590' ./2-less.sh
gzip_v='1.12' ./2-gzip.sh
iproute_v='5.19.0' ./2-iproute.sh
kbd_v='2.5.1' ./2-kbd.sh
libpipeline_v='1.5.6' ./2-libpipeline.sh
make_v='4.3' ./2-make.sh
patch_v='2.7.6' ./2-patch.sh
sysklogd_v='1.5.1' ./2-sysklogd.sh
sysvinit_v='3.04' ./2-sysvinit.sh
eudev_v='3.2.11' ./2-eudev.sh
utillinux_v='2.38.1' ./2-util-linux.sh
mandb_v='2.10.2' ./2-mandb.sh
tar_v='1.34' ./2-tar.sh
texinfo_v='6.8' ./2-texinfo.sh
vim_v='9.0.0228' ./2-vim.sh
openssl_v='3.0.5' ./2-openssl.sh
./2-cleanup.sh
