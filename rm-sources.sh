#!/bin/bash

for file in $(cat wget-list | sed -e 's:.*/::g') ; do
	rm $file
done

exit 0
