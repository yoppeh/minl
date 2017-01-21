#!/bin/bash
if [ -f $PROGRESS_DIR/2-iproute ] ; then
	exit 0
fi
echo "building iproute..."
set -e
tar xf iproute2-${iproute_v}.tar.xz
cd iproute2-${iproute_v}
sed -i /ARPD/d Makefile
sed -i 's/arpd.8//' man/man8/Makefile
rm doc/arpd.sgml
sed -i 's/m_ipt.o//' tc/Makefile
make
make DOCDIR=/usr/share/doc/iproute2-${iproute_v} install
cd ..
rm -rf iproute2-${iproute_v}
touch $PROGRESS_DIR/2-iproute
