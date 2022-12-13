#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-efibootmgr ] ; then
	exit 0
fi

echo "building efibootmgr..."

set -e

tar xf efibootmgr-${efibootmgr_v}.tar.gz
cd efibootmgr-${efibootmgr_v}

make EFIDIR=minl EFI_LOADER=grubx64.efi
make install EFIDIR=minl

cd ..
rm -rf efibootmgr-${efibootmgr_v}
touch $PROGRESS_DIR/2-efibootmgr
