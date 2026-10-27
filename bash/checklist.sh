#!/bin/bash
check_file() {
    if [ -f $1 ]; then
        echo "OK: $1"
    else
        echo "MISSING: $1"
    fi
}

while read line; do
    check_file $line
done < files.txt

