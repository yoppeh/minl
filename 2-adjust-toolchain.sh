#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-adjust-toolchain ] ; then
	exit 0
fi

echo "adjusting toolchain..."

set -e

mv /tools/bin/{ld,ld-old}
mv /tools/$(uname -m)-pc-linux-gnu/bin/{ld,ld-old}
mv /tools/bin/{ld-new,ld}

ln -s /tools/bin/ld /tools/$(uname -m)-pc-linux-gnu/bin/ld

gcc -dumpspecs | sed -e 's@/tools@@g' -e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}' -e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' > `dirname $(gcc --print-libgcc-file-name)`/specs

touch $PROGRESS_DIR/2-adjust-toolchain
