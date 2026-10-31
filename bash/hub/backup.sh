#!/bin/bash
echo "Enter source directory"
read src

if [ ! -d $src ]; then
	echo " Directory does not exist"
exit 1
fi

backup="backup_$(date +%F_%H-%M)"
mkdir -p $backup
echo "Backup directory created:$backup"
cp $src/*.txt $backup/

count=$(ls $backup | wc -l)
echo "Backup complete! Files backed up: $count"

