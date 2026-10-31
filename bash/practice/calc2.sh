#!/bin/bash
echo "Enter first number"
read num1 
echo "Enter second number"
read num2

echo " $num1 + $num2 = $(( num1 + num2 ))"
echo " $num1 - $num2 = $(( num1 - num2 ))"
echo " $num1 * $num2 = $(( num1 * num2 ))"

if [ $num2 -eq 0 ]; then
echo "Error: Number can't be divided by 0"
else
	echo " $num1 / $num2 = $(( $num1 / $num2 ))"
fi
