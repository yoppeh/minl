#!/bin/bash
if [ -f $PROGRESS_DIR/1-expect ] ; then
	exit 0
fi
echo "building expect..."
set -e
cd $MINL/sources
rm -rf expect${expect_v}
tar xf expect${expect_v}.tar.gz
cd expect${expect_v}
cp configure{,.orig}
sed 's:/usr/local/bin:/bin:' configure.orig > configure
./configure --prefix=/tools --with-tcl=/tools/lib --with-tclinclude=/tools/include
make
make SCRIPTS="" install
cd ..
rm -rf expect${expect_v}
touch $PROGRESS_DIR/1-expect
