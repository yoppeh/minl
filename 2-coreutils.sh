#!/bin/bash
if [ -f $PROGRESS_DIR/2-coreutils ] ; then
	exit 0
fi
echo "building coreutils..."
set -e
set -h
tar xf coreutils-${coreutils_v}.tar.xz
cd coreutils-${coreutils_v}
patch -Np1 -i ../coreutils-8.26-i18n-1.patch
FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=/usr --enable-no-install-program=kill,uptime
FORCE_UNSAFE_CONFIGURE=1 make
make install
mv /usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} /bin
mv /usr/bin/{false,ln,ls,mkdir,mknod,pwd,rm} /bin
mv /usr/bin/{rmdir,stty,sync,true,uname} /bin
mv /usr/bin/chroot /usr/sbin
mv /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
sed -i s/\"1\"/\"8\"/1 /usr/share/man/man8/chroot.8
mv /usr/bin/{head,sleep,nice,test,[} /bin
cd ..
/bin/rm -rf coreutils-${coreutils_v}
touch $PROGRESS_DIR/2-coreutils
