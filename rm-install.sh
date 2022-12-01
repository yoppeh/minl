#!/bin/bash
#
# This script removes a (possibly partial) minl installation. Good for
# when you need to just start over.

. ./environment.sh

umount -R $MINL
rm -rf $MINL
rm -rf /target
rm -rf /tools
