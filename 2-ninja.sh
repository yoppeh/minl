#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

if [ -f $PROGRESS_DIR/2-ninja ] ; then
	exit 0
fi

echo "building ninja..."

set -e

tar xf ninja-${ninja_v}.tar.gz
cd ninja-${ninja_v}

export NINJAJOBS=4
sed -i '/int Guess/a \
    int j = 0;\
    char *jobs = getenv( "NINJAJOBS" );\
    if (jobs != NULL ) j = atoi( jobs );\
    if ( j > 0 ) return j;\
    ' src/ninja.cc
python3 configure.py --bootstrap
install -m755 ninja /usr/bin/
install -Dm644 misc/bash-completion /usr/share/bash-completion/completions/ninja
install -Dm644 misc/zsh-completion /usr/share/zsh/site-functions/_ninja

cd ..
rm -rf ninja-${ninja_v}
touch $PROGRESS_DIR/2-ninja
