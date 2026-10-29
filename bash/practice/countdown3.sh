#!/bin/bash
set -x
count=$1
while [ $count -gt 0 ]; do
	echo $count
((count--))
done
echo "Go!"
