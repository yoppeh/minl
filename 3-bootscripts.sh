#!/bin/bash
if [ -f $PROGRESS_DIR/3-bootscripts ] ; then
	exit 0
fi
echo "installing bootscripts..."
set -e
tar xf lfs-bootscripts-${bootscripts_v}.tar.bz2
cd lfs-bootscripts-${bootscripts_v}
make install
/bin/bash /lib/udev/init-net-rules.sh
cd ..
rm -rf lfs-bootscripts-${bootscripts_v}
touch $PROGRESS_DIR/3-bootscripts
