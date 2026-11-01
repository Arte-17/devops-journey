#!/bin/bash
#Takes a snapshot of the computer and saves it to a dated log file. Checks if the CPU is busy, memory or disk is full, and what's eating the memory. First thing to run on a slow server.

#name the log with the date

logfile="sysmon_$(date +%F_%H-%M).log"

#the 4 checks, all saved into the log

{
echo "--- CPU ---"
top -bn1 | head -5

echo "--- Memory ---"
free -h

echo "--- Disk ---"
df -h /
echo "--- Top 5 processes by memory ---"
ps aux --sort=-%mem | head -6
} > $logfile

#tell the user, and show the report

echo "Report saved to $logfile"
cat $logfile
