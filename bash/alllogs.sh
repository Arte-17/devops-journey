#!/bin/bash
for file in *.log; do
	 if [ $file == "api.log" ]; then
        continue
    fi
    echo "== $file =="
    topip.sh $file
done
