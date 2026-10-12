#!/bin/bash
cut -d ' ' -f1 $1 | sort | uniq -c | sort -nr

