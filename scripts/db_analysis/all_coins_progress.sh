#!/bin/bash
set -e

echo
echo "### All Coins Progress"
echo "\`all_coin_progress.sh\`"
echo

DATABASE=../../crypto_trading.db
echo "Coin|Starting value|Last value|Grow %"
echo "---|---|---|---"

while read p; do
   #echo "Coin: "
   #echo $p
   jumps=$(sqlite3 $DATABASE "select count(id) from trade_history where alt_coin_id='$p' and selling=0 and state='COMPLETE';")
   if [ $jumps -gt 0 ]
   then
     #echo "**Starting value:** "
     first_value=$(sqlite3 $DATABASE "select alt_trade_amount from trade_history where alt_coin_id='$p' and selling=0 and state='COMPLETE' order by id asc limit 1;")
     last_value=$(sqlite3 $DATABASE "select alt_trade_amount from trade_history where alt_coin_id='$p' and selling=0 and state='COMPLETE' order by id DESC limit 1;")
     grow=$(awk "BEGIN {print ($last_value/$first_value*100)-100}")
     echo "$p|$first_value|$last_value|$grow"

   else
     echo "$p|-|-|-"
     #echo "_Coin has not yet been bought_"
   fi
     #echo
done <../../supported_coin_list

echo
echo "\`-\` indicates never bought"
