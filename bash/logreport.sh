#!/bin/bash
set -euo pipefail
logfile=$1
if [ ! -f $logfile ]; then 
	echo "Error: $1 not found"
exit 1 
fi
echo "Report for: $1"
echo "Run by: $USER on $(date)" 
echo "Lines: $( wc -l < $1 )"
top_ip() {
	cut -d ' ' -f1 $1 | sort | uniq -c | sort -nr | head -n 3
}
echo "Top IPs:"
top_ip $logfile
