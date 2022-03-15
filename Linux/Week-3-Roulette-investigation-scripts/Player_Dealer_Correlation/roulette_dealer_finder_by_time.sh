#!/bin/bash
#the time
time=${2//[!0-9]/}
#AM/PM
clock='AM'
if [[ "$2" == *'p'* ]]; then
 clock='PM'
fi
cat $1_Dealer_schedule | grep $time | grep $clock | awk '{print $1,$2,$5,$6}'

