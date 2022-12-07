#!/bin/bash

. ./environment.sh
. ./package-versions.sh

export FORCE_UNSAFE_CONFIGURE=1

set -e

chroot "$MINL" /usr/bin/env -i \
    HOME=/root \
    TERM="$TERM" \
    PS1='(minl chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin \
    /bin/bash --login
