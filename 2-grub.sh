#!/bin/bash

if [ -f $PROGRESS_DIR/2-grub ] ; then
	exit 0
fi

echo "building grub..."

set -e

tar xf grub-${grub_v}.tar.xz
cd grub-${grub_v}

./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --disable-efiemu \
    --enable-grub-mkfont \
    --with-platform=efi \
    --target=x86_64 \
    --disable-werror
unset TARGET_CC && make
make install
mv /etc/bash_completion.d/grub /usr/share/bash-completion/completions

cd ..
rm -rf grub-${grub_v}
touch $PROGRESS_DIR/2-grub
