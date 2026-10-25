#!/bin/bash
score=$1
if [ $score -ge 70 ]; then
       echo "Distinction"
elif [ $score -ge 50 ]; then
echo "Pass"
else 
	echo "Fail"
fi
