#!/tools/bin/bash

[ -z "$MINLENV" ] && exec env -i MINLENV=1 /tools/bin/bash "$0"

export FORCE_UNSAFE_CONFIGURE=1
export PATH=/bin:/usr/bin:/sbin:/tools/bin:/tools/sbin

. ./environment.sh

set -e

/tools/bin/bash ./2-filesystem.sh
linux_v='4.9.2' ./2-linux-headers.sh
man_pages_v='4.09' ./2-man-pages.sh
glibc_v='2.24' ./2-glibc.sh
./2-adjust-toolchain.sh
zlib_v='1.2.11' ./2-zlib.sh
file_v='5.29' ./2-file.sh
binutils_v='2.27' ./2-binutils.sh
gmp_v='6.1.2' ./2-gmp.sh
mpfr_v='3.1.5' ./2-mpfr.sh
mpc_v='1.0.3' ./2-mpc.sh
gcc_v='6.3.0' ./2-gcc.sh
bzip2_v='1.0.6' ./2-bzip2.sh
pkg_config_v='0.29.1' ./2-pkg-config.sh
ncurses_v='6.0' ./2-ncurses.sh
attr_v='2.4.47' ./2-attr.sh
acl_v='2.2.52' ./2-acl.sh
libcap_v='2.25' ./2-libcap.sh
sed_v='4.3' ./2-sed.sh
shadow_v='4.2.1' ./2-shadow.sh
psmisc_v='22.21' ./2-psmisc.sh
iana_etc_v='2.30' ./2-iana-etc.sh
m4_v='1.4.18' ./2-m4.sh
bison_v='3.0.4' ./2-bison.sh
flex_v='2.6.3' ./2-flex.sh
grep_v='2.27' ./2-grep.sh
readline_v='7.0' ./2-readline.sh
bash_v='4.4' ./2-bash.sh
#dash_v='0.5.9.1' ./2-dash.sh
bc_v='1.06.95' ./2-bc.sh
libtool_v='2.4.6' ./2-libtool.sh
gdbm_v='1.12' ./2-gdbm.sh
gperf_v='3.1' ./2-gperf.sh
expat_v='2.2.0' ./2-expat.sh
inetutils_v='1.9.4' ./2-inetutils.sh
perl_v='5.24.0' ./2-perl.sh
xml_parser_v='2.44' ./2-xml-parser.sh
intltool_v='0.51.0' ./2-intltool.sh
autoconf_v='2.69' ./2-autoconf.sh
automake_v='1.15' ./2-automake.sh
xz_v='5.2.3' ./2-xz.sh
kmod_v='23' ./2-kmod.sh
gettext_v='0.19.8.1' ./2-gettext.sh
procps_v='3.3.12' ./2-procps.sh
e2fsprogs_v='1.43.3' ./2-e2fsprogs.sh
coreutils_v='8.26' ./2-coreutils.sh
diffutils_v='3.5' ./2-diffutils.sh
gawk_v='4.1.4' ./2-gawk.sh
findutils_v='4.6.0' ./2-findutils.sh
groff_v='1.22.3' ./2-groff.sh
grub_v='2.02~beta3' ./2-grub.sh
less_v='481' ./2-less.sh
gzip_v='1.8' ./2-gzip.sh
iproute_v='4.9.0' ./2-iproute.sh
kbd_v='2.0.3' ./2-kbd.sh
libpipeline_v='1.4.1' ./2-libpipeline.sh
make_v='4.2.1' ./2-make.sh
patch_v='2.7.5' ./2-patch.sh
sysklogd_v='1.5.1' ./2-sysklogd.sh
sysvinit_v='2.88dsf' ./2-sysvinit.sh
eudev_v='3.2.1' ./2-eudev.sh
utillinux_v='2.29' ./2-util-linux.sh
mandb_v='2.7.6.1' ./2-mandb.sh
tar_v='1.29' ./2-tar.sh
texinfo_v='6.3' ./2-texinfo.sh
vim_v='8.0.069' ./2-vim.sh
openssl_v='1.1.0c' ./2-openssl.sh
./2-cleanup.sh

