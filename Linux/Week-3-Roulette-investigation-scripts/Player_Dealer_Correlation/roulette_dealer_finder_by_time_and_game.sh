#!/bin/bash
#time
time=${2//[!0-9]/}
#AM or PM
clock='AM'
if [[ "$2" == *'p'* ]]; then
 clock='PM'
fi
#case-insensitive
shopt -s nocasematch
#match game and print
if [[ "BlackJack" =~ .*"$3".* ]]; then
 cat $1_Dealer_schedule | grep $time | grep $clock | awk '{print $1,$2,$3,$4}'
else
if [[ "Roulette" =~ .*"$3".* ]]; then
 cat $1_Dealer_schedule | grep $time | grep $clock | awk '{print $1,$2,$5,$6}'
else
if [[ "Texas Hold Em" =~ .*"$3".* ]]; then
 cat $1_Dealer_schedule | grep $time | grep $clock | awk '{print $1,$2,$7,$8}'
  fi
 fi
fi

