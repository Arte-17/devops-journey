#!/bin/bash
 # make the folder
mkdir bash_demo
echo "bash_demo created"

# go into that folder
cd bash_demo
echo "Now inside bash_demo"

# make demo.txt with text and date
echo "This file was created by a Bash script on $(date)" > demo.txt
echo "File 'demo.txt' created" 

# show what's in the file.
echo "File contents:"  
cat demo.txt

