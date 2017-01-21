#!/bin/bash
if [ -f $PROGRESS_DIR/2-bash ] ; then
	exit 0
fi
echo "building bash..."
set -e
tar xf bash-${bash_v}.tar.gz
cd bash-${bash_v}
./configure --prefix=/usr --docdir=/usr/share/doc/bash-${bash_v} --without-bash-malloc --with-installed-readline
make
make install
mv -f /usr/bin/bash /bin
cd ..
rm -rf bash-${bash_v}
touch $PROGRESS_DIR/2-bash
