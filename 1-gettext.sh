#!/bin/bash
if [ -f $PROGRESS_DIR/1-gettext ] ; then
	exit 0
fi
echo "building gettext..."
set -e
cd $MINL/sources
rm -rf gettext-${gettext_v}
tar xf gettext-${gettext_v}.tar.xz
cd gettext-${gettext_v}/gettext-tools
EMACS="no" ./configure --prefix=/tools --disable-shared
make -C gnulib-lib
make -C intl pluralx.c
make -C src msgfmt
make -C src msgmerge
make -C src xgettext
cp src/{msgfmt,msgmerge,xgettext} /tools/bin
cd ../..
rm -rf gettext-${gettext_v}
touch $PROGRESS_DIR/1-gettext
