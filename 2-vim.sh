#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-vim ] ; then
    exit 0
fi

echo "building vim..."

set -e

tar xf vim-${vim_v}.tar.gz
cd vim-${vim_series_v}

echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
./configure --prefix=/usr
make
make install

ln -s vim /usr/bin/vi
for L in /usr/share/man/{,*/}man1/vim.1; do
    ln -s vim.1 $(dirname $L)/vi.1
done

ln -s ../vim/vim${vim_series_v}/doc /usr/share/doc/vim-${vim_v}

cat > /etc/vimrc << "EOF"
set nocompatible
set backspace=2
syntax on
if (&term == "iterm") || (&term == "putty")
    set background=dark
endif
EOF

cd ..
rm -rf vim-${vim_series_v}
touch $PROGRESS_DIR/2-vim
