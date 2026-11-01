#!/bin/bash

# Asks for a folder and checks it exists (guard stops it if not). Copies all .txt files into a new backup folder with the date and time in its name, then counts them. The kind of backup you'd run before changing anything on a server.

#ask

echo "Enter source directory"
read src

#guard

if [ ! -d $src ]; then
	echo " Directory does not exist"
exit 1
fi
#make the dated folder

backup="backup_$(date +%F_%H-%M)"
mkdir -p $backup
echo "Backup directory created:$backup"

#copy

cp $src/*.txt $backup/

#count

count=$(ls $backup | wc -l)
echo "Backup complete! Files backed up: $count"

