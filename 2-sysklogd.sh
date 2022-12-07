#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-sysklogd ] ; then
	exit 0
fi

echo "building sysklogd..."

set -e

tar xf sysklogd-${sysklogd_v}.tar.gz
cd sysklogd-${sysklogd_v}

sed -i '/Error loading kernel symbols/{n;n;d}' ksym_mod.c
sed -i 's/union wait/int/' syslogd.c
make
make BINDIR=/sbin install

cat > /etc/syslog.conf << "EOF"
auth,authpriv.* -/var/log/auth.log
*.*;auth,authpriv.none -/var/log/sys.log
daemon.* -/var/log/daemon.log
kern.* -/var/log/kern.log
mail.* -/var/log/mail.log
user.* -/var/log/user.log
*.emerg *
EOF

cd ..
rm -rf sysklogd-${sysklogd_v}
touch $PROGRESS_DIR/2-sysklogd
