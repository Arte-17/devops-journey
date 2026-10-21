#!/bin/bash
echo "How old are you?"
read age 

if [[ $age =~ ^[0-9]+$ ]]; then
	if [ $age -gt 150 ]; then
    echo "Are you a ghost?"
elif [ $age -ge 18 ]; then
    echo "You are an adult"
else
    echo "You are under 18"
fi
else
	echo "Please type a number"
fi
