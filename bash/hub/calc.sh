#!/bin/bash
# ask for two numbers
echo "Enter first number:"
read num1
echo "Enter second number:"
read num2

# add, subtract, multiply
echo "$num1 + $num2 = $((num1 + num2))"
echo "$num1 - $num2 = $((num1 - num2))"
echo "$num1 * $num2 = $((num1 * num2))"

# divide, but only if the second number isn't 0
if [ $num2 -eq 0 ]; then
    echo "ERROR: Can't divide by 0"
else
    echo "$num1 / $num2 = $((num1 / num2))"
fi


