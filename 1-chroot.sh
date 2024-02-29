#!/bin/bash

export STAGE=1

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

set -e

chroot "$MINL" /usr/bin/env -i \
    HOME=/root \
    TERM="$TERM" \
    PS1='(${SYS_NAME} chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin \
    MAKEFLAGS=$MAKEFLAGS \
    TESTSUITEFLAGS=$MAKEFLAGS \
    /bin/bash --login
