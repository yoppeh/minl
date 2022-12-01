#!/bin/bash

if [ -f $PROGRESS_DIR/2-xml-parser ] ; then
	exit 0
fi

echo "building xml-parser..."

set -e

tar xf XML-Parser-${xml_parser_v}.tar.gz
cd XML-Parser-${xml_parser_v}

perl Makefile.PL
make
make install

cd ..
rm -rf XML-Parser-${xml_parser_v}
touch $PROGRESS_DIR/2-xml-parser
