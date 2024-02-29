#!/bin/bash

export STAGE=2

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-python-$PASS ] ; then
    exit 0
fi

echo "building python pass ${PASS}..."

set -e

tar xf Python-${python_v}.tar.xz
cd Python-${python_v}

if [ "$PASS" == "1" ] ; then
    ./configure \
        --prefix=/usr \
        --enable-shared \
        --without-ensurepip
else
    ./configure \
        --prefix=/usr \
        --enable-shared \
        --with-system-expat \
        --enable-optimizations
fi
make
make install

if [ "$PASS" == "2" ] ; then
cat > /etc/pip.conf << "EOF"
[global]
root-user-action = ignore
disable-pip-version-check = true
EOF
fi

cd ..
rm -rf Python-${python_v}
touch $PROGRESS_DIR/2-python-$PASS
