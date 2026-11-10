#!/bin/bash
# check the file exists, stop if not
if [ ! -f $1 ]; then
    echo "Error: $1 not found"
    exit 1
fi
# count the lines and show them
echo "$1 has $(wc -l < $1) lines"
