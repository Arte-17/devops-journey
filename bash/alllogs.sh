#!/bin/bash
for file in *.log; do
    echo "== $file =="
    topip.sh $file
done
