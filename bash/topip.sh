#!/bin/bash
if [ -f $1 ]; then
cut -d ' ' -f1 $1 | sort | uniq -c | sort -nr
else
	echo "Error: $1 not found"
fi

