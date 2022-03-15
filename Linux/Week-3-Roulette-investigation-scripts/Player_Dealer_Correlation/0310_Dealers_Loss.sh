
#!bin/bash
echo "March 10"
awk '/0[58].+AM|(0[28]|11).+PM/{print$1,$2,$5,$6}' 0310_Dealer_schedule

#!bin/bash
echo "March 12"
awk '/0[58].+AM|(0[28]|11).+PM/{print$1,$2,$5,$6}' 0312_Dealer_schedule

#!bin/bash
echo "March 15"
awk '/0[58].+AM|02.+PM/{print$1,$2,$5,$6}' 0315_Dealer_schedule

