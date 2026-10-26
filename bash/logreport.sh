#!/bin/bash
set -euo pipefail
logfile=$1
if [ ! -f $logfile ]; then 
	echo "Error: $1 not found"
exit 1 
fi
echo "Report for: $1"
echo "Run by:$USER on $(date)"  
