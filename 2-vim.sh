#!/bin/bash
if [ -f $PROGRESS_DIR/2-vim ] ; then
	exit 0
fi
echo "building vim..."
set -e
export vim_d=80
tar xf vim-${vim_v}.tar.bz2
cd vim${vim_d}
echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
./configure --prefix=/usr
make
make install
ln -s vim /usr/bin/vi
for L in /usr/share/man/{,*/}man1/vim.1; do
	ln -s vim.1 $(dirname $L)/vi.1
done
ln -s ../vim/vim80/doc /usr/share/doc/vim-8.0.069
cat > /etc/vimrc << "EOF"
set nocompatible
set backspace=2
syntax on
if (&term == "iterm") || (&term == "putty")
	set background=dark
endif
EOF
cd ..
rm -rf vim${vim_d}
touch $PROGRESS_DIR/2-vim
