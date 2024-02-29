#!/bin/bash

. ./package-versions.sh

echo "" > wget-list
echo "https://download.savannah.gnu.org/releases/acl/acl-${acl_v}.tar.xz" >> wget-list
echo "https://download.savannah.gnu.org/releases/attr/attr-${attr_v}.tar.gz" >> wget-list
echo "https://ftp.gnu.org/gnu/autoconf/autoconf-${autoconf_v}.tar.xz" >> wget-list
echo "https://ftp.gnu.org/gnu/automake/automake-${automake_v}.tar.xz" >> wget-list
echo "https://ftp.gnu.org/gnu/bash/bash-${bash_v}.tar.gz" >> wget-list
echo "https://github.com/gavinhoward/bc/releases/download/${bc_v}/bc-${bc_v}.tar.xz" >> wget-list
echo "https://sourceware.org/pub/binutils/releases/binutils-${binutils_v}.tar.xz" >> wget-list
echo "https://ftp.gnu.org/gnu/bison/bison-${bison_v}.tar.xz" >> wget-list
echo "https://www.sourceware.org/pub/bzip2/bzip2-${bzip2_v}.tar.gz" >> wget-list
echo "https://github.com/libcheck/check/releases/download/${check_v}/check-${check_v}.tar.gz" >> wget-list
echo "https://ftp.gnu.org/gnu/coreutils/coreutils-${coreutils_v}.tar.xz" >> wget-list
echo "https://dbus.freedesktop.org/releases/dbus/dbus-${dbus_v}.tar.xz" >> wget-list
echo "https://ftp.gnu.org/gnu/dejagnu/dejagnu-${dejagnu_v}.tar.gz" >> wget-list
echo "https://ftp.gnu.org/gnu/diffutils/diffutils-${diffutils_v}.tar.xz" >> wget-list
echo "https://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v${e2fsprogs_v}/e2fsprogs-${e2fsprogs_v}.tar.gz" >> wget-list
echo "https://sourceware.org/ftp/elfutils/${elfutils_v}/elfutils-${elfutils_v}.tar.bz2" >> wget-list
echo "https://prdownloads.sourceforge.net/expat/expat-${expat_v}.tar.xz" >> wget-list
echo "https://prdownloads.sourceforge.net/expect/expect${expect_v}.tar.gz" >> wget-list
echo "https://astron.com/pub/file/file-${file_v}.tar.gz" >> wget-list
echo "https://ftp.gnu.org/gnu/findutils/findutils-${findutils_v}.tar.xz" >> wget-list
echo "https://github.com/westes/flex/releases/download/v${flex_v}/flex-${flex_v}.tar.gz" >> wget-list
echo "https://pypi.org/packages/source/f/flit-core/flit_core-${flit_core_v}.tar.gz" >> wget-list
echo "https://ftp.gnu.org/gnu/gawk/gawk-${gawk_v}.tar.xz" >> wget-list
echo "https://ftp.gnu.org/gnu/gcc/gcc-${gcc_v}/gcc-${gcc_v}.tar.xz" >> wget-list
echo "https://ftp.gnu.org/gnu/gdbm/gdbm-${gdbm_v}.tar.gz" >> wget-list
echo "https://ftp.gnu.org/gnu/gettext/gettext-${gettext_v}.tar.xz" >> wget-list
echo "https://ftp.gnu.org/gnu/glibc/glibc-${glibc_v}.tar.xz" >> wget-list
echo "https://ftp.gnu.org/gnu/gmp/gmp-${gmp_v}.tar.xz" >> wget-list
echo "https://ftp.gnu.org/gnu/gperf/gperf-${gperf_v}.tar.gz" >> wget-list
echo "https://ftp.gnu.org/gnu/grep/grep-${grep_v}.tar.xz" >> wget-list
echo "https://ftp.gnu.org/gnu/groff/groff-${groff_v}.tar.gz" >> wget-list
echo "https://ftp.gnu.org/gnu/gzip/gzip-${gzip_v}.tar.xz" >> wget-list
echo "https://github.com/Mic92/iana-etc/releases/download/${iana_etc_v}/iana-etc-${iana_etc_v}.tar.gz" >> wget-list
echo "https://ftp.gnu.org/gnu/inetutils/inetutils-${inetutils_v}.tar.xz" >> wget-list
echo "https://launchpad.net/intltool/trunk/${intltool_v}/+download/intltool-${intltool_v}.tar.gz" >> wget-list
echo "https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-${iproute2_v}.tar.xz" >> wget-list
echo "https://pypi.org/packages/source/J/Jinja2/Jinja2-${jinja2_v}.tar.gz" >> wget-list
echo "https://www.kernel.org/pub/linux/utils/kbd/kbd-${kbd_v}.tar.xz" >> wget-list
echo "https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-${kmod_v}.tar.xz" >> wget-list
echo "https://www.greenwoodsoftware.com/less/less-${less_v}.tar.gz" >> wget-list
echo "https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-${libcap_v}.tar.xz" >> wget-list
echo "https://github.com/libffi/libffi/releases/download/v${libffi_v}/libffi-${libffi_v}.tar.gz" >> wget-list
echo "https://download.savannah.gnu.org/releases/libpipeline/libpipeline-${libpipeline_v}.tar.gz" >> wget-list
echo "https://ftp.gnu.org/gnu/libtool/libtool-${libtool_v}.tar.xz" >> wget-list
echo "https://github.com/besser82/libxcrypt/releases/download/v${libxcrypt_v}/libxcrypt-${libxcrypt_v}.tar.xz" >> wget-list
echo "https://www.kernel.org/pub/linux/kernel/v${linux_major_v}.x/linux-${linux_v}.tar.xz" >> wget-list
echo "https://ftp.gnu.org/gnu/m4/m4-${m4_v}.tar.xz" >> wget-list
echo "https://ftp.gnu.org/gnu/make/make-${make_v}.tar.gz" >> wget-list
echo "https://download.savannah.gnu.org/releases/man-db/man-db-${mandb_v}.tar.xz" >> wget-list
echo "https://www.kernel.org/pub/linux/docs/man-pages/man-pages-${man_pages_v}.tar.xz" >> wget-list
echo "https://pypi.org/packages/source/M/MarkupSafe/MarkupSafe-${markupsafe_v}.tar.gz" >> wget-list
echo "https://github.com/mesonbuild/meson/releases/download/${meson_v}/meson-${meson_v}.tar.gz" >> wget-list
echo "https://ftp.gnu.org/gnu/mpc/mpc-${mpc_v}.tar.gz" >> wget-list
echo "https://ftp.gnu.org/gnu/mpfr/mpfr-${mpfr_v}.tar.xz" >> wget-list
echo "https://anduin.linuxfromscratch.org/LFS/ncurses-${ncurses_v}.tar.xz" >> wget-list
echo "https://github.com/ninja-build/ninja/archive/v${ninja_v}/ninja-${ninja_v}.tar.gz" >> wget-list
echo "https://www.openssl.org/source/openssl-${openssl_v}.tar.gz" >> wget-list
echo "https://ftp.gnu.org/gnu/patch/patch-${patch_v}.tar.xz" >> wget-list
echo "https://www.cpan.org/src/${perl_series_v}/perl-${perl_v}.tar.xz" >> wget-list
echo "https://distfiles.ariadne.space/pkgconf/pkgconf-${pkgconf_v}.tar.xz" >> wget-list
echo "https://sourceforge.net/projects/procps-ng/files/Production/procps-ng-${procps_ng_v}.tar.xz" >> wget-list
echo "https://sourceforge.net/projects/psmisc/files/psmisc/psmisc-${psmisc_v}.tar.xz" >> wget-list
echo "https://www.python.org/ftp/python/${python_v}/Python-${python_v}.tar.xz" >> wget-list
echo "https://www.python.org/ftp/python/doc/${python_v}/python-${python_v}-docs-html.tar.bz2" >> wget-list
echo "https://ftp.gnu.org/gnu/readline/readline-${readline_v}.tar.gz" >> wget-list
echo "https://ftp.gnu.org/gnu/sed/sed-${sed_v}.tar.xz" >> wget-list
echo "https://pypi.org/packages/source/s/setuptools/setuptools-${setuptools_v}.tar.gz" >> wget-list
echo "https://github.com/shadow-maint/shadow/releases/download/${shadow_v}/shadow-${shadow_v}.tar.xz" >> wget-list
echo "https://github.com/systemd/systemd/archive/v${systemd_v}/systemd-${systemd_v}.tar.gz" >> wget-list
echo "https://anduin.linuxfromscratch.org/LFS/systemd-man-pages-${systemd_v}.tar.xz" >> wget-list
echo "https://ftp.gnu.org/gnu/tar/tar-${tar_v}.tar.xz" >> wget-list
echo "https://downloads.sourceforge.net/tcl/tcl${tcl_v}-src.tar.gz" >> wget-list
echo "https://downloads.sourceforge.net/tcl/tcl${tcl_v}-html.tar.gz" >> wget-list
echo "https://ftp.gnu.org/gnu/texinfo/texinfo-${texinfo_v}.tar.xz" >> wget-list
echo "https://www.iana.org/time-zones/repository/releases/tzdata${tzdata_v}.tar.gz" >> wget-list
echo "https://www.kernel.org/pub/linux/utils/util-linux/v${util_linux_base_v}/util-linux-${util_linux_v}.tar.xz" >> wget-list
echo "https://github.com/vim/vim/archive/v${vim_v}/vim-${vim_v}.tar.gz" >> wget-list
echo "https://pypi.org/packages/source/w/wheel/wheel-${wheel_v}.tar.gz" >> wget-list
echo "https://ftp.gnu.org/gnu/which/which-${which_v}.tar.gz" >> wget-list
echo "https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-${xml_parser_v}.tar.gz" >> wget-list
echo "https://github.com/tukaani-project/xz/releases/download/v${xz_v}/xz-${xz_v}.tar.xz" >> wget-list
echo "https://zlib.net/fossils/zlib-${zlib_v}.tar.gz" >> wget-list
echo "https://github.com/facebook/zstd/releases/download/v${zstd_v}/zstd-${zstd_v}.tar.gz" >> wget-list

echo "https://www.linuxfromscratch.org/patches/lfs/${lfs_v}/bash-${bash_v}-upstream_fixes-1.patch" >> wget-list
echo "https://www.linuxfromscratch.org/patches/lfs/${lfs_v}/bzip2-${bzip2_v}-install_docs-1.patch" >> wget-list
echo "https://www.linuxfromscratch.org/patches/lfs/${lfs_v}/coreutils-${coreutils_v}-i18n-1.patch" >> wget-list
echo "https://www.linuxfromscratch.org/patches/lfs/${lfs_v}/glibc-${glibc_v}-fhs-1.patch" >> wget-list
echo "https://www.linuxfromscratch.org/patches/lfs/${lfs_v}/kbd-${kbd_v}-backspace-1.patch" >> wget-list
echo "https://www.linuxfromscratch.org/patches/lfs/${lfs_v}/readline-${readline_v}-upstream_fixes-3.patch" >> wget-list
echo "https://www.linuxfromscratch.org/patches/lfs/${lfs_v}/systemd-${systemd_v}-upstream_fixes-1.patch" >> wget-list

wget --input-file=wget-list --continue --rejected-log=wget-list-rejected

echo "the following files were not downloaded:"
export FC=0
for file in $(cat wget-list | sed -e 's:.*/::g') ; do
    if [ ! -f $file ] ; then
        export FC=1
        echo $file
    fi
done
if [ "$FC" == "0" ] ; then
    echo "*** none ***"
fi

exit 0
