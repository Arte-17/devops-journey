#!/bin/bash 
length=$1
width=$2
area=$((length * width))
perimeter=$((2 * (length + width)))
echo "rectangle area: $area"
echo "rectangle perimeter: $perimeter"
