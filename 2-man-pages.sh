#!/bin/bash
if [ -f $PROGRESS_DIR/2-man-pages ] ; then
	exit 0
fi
echo "building man pages..."
set -e
rm -rf man-pages-${man_pages_v}
tar xf man-pages-${man_pages_v}.tar.xz
cd man-pages-${man_pages_v}
make install
cd ..
rm -rf man-pages-${man_pages_v}
touch $PROGRESS_DIR/2-man-pages
