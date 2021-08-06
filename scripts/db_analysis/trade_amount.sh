#!/bin/bash
set -e

echo
echo "### Trade Amounts"
echo "\`trade_amount.sh\`"
echo

echo "Date|Coin|Amount"
echo "---|---|---"

while read -r i; do
sqlite3 ../../crypto_trading.db <<EOF
SELECT "datetime", "alt_coin_id", "alt_trade_amount"  FROM (SELECT * FROM 'trade_history' WHERE alt_coin_id="$i") WHERE selling = FALSE ORDER BY datetime DESC
EOF
done < ../../supported_coin_list

echo
