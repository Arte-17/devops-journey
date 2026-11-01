#!/bin/bash
# Asks for a file and checks it exists (exit 1 guard stops it if not). Then checks if it's readable, writable and executable. Handy for "permission denied" tickets.

# ask for a file

echo "Enter filename to check"
read file

# stop if it doesn't exist

if [ ! -f $file ]; then
	echo "File '$file' is missing"
exit 1

fi


echo "File '$file' exists"

# check read / write / execute

if [ -r $file ]; then
	echo "File is readable"
else


	echo "File is not readable"

fi	
	if [ -w $file ]; then
        echo "File is writable"
else
	
        echo "File is not writable"    
	
	fi

	if [ -x $file ]; then
        echo "File is executable"
else
        echo "File is not executable"
	
fi
