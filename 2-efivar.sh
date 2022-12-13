#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-efivar ] ; then
	exit 0
fi

echo "building efivar..."

set -e

tar xf efivar-${efivar_v}.tar.bz2
cd efivar-${efivar_v}

sed '/prep :/a\\ttouch prep' -i src/Makefile
sed '/sys\/mount\.h/d' -i src/util.h
sed '/unistd\.h/a#include <sys/mount.h>' -i src/gpt.c src/linux.c

make
make install LIBDIR=/usr/lib

cd ..
rm -rf efivar-${efivar_v}
touch $PROGRESS_DIR/2-efivar
