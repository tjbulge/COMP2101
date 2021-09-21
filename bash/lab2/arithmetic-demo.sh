#!/bin/bash
#
# this script demonstrates doing arithmetic

# Task 1: Remove the assignments of numbers to the first and second number variables. Use one or more read commands to get 3 numbers from the user.
# Task 2: Change the output to only show:
#    the sum of the 3 numbers with a label
#    the product of the 3 numbers with a label

read -p "Please enter a number: " firstnum
read -p "Please enter a second number: " secondnum
read -p "Enter a third number: " thirdnum

sum=$((firstnum + secondnum + thirdnum ))
product=$((firstnum * secondnum * thirdnum))
#fpdividend=$(awk "BEGIN{printf \"%.2f\", $firstnum/$secondnum}")

cat <<EOF

The sum of all three numbers is $sum
The product of all three numbers is $product
EOF
# - More precisely, it is $fpdividend

