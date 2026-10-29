#!/bin/bash
check_file () {
	if [ -f $1 ]; then
	       echo "OK: $1"
       else
echo "MISSING: $1"	       
	fi
}
check_file access.log
check_file web.log
check_file fake.log
