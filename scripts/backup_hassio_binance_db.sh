#!/bin/bash
set -e

cd scripts/db_analysis

sh current_coin_ratio.sh
sh current_coin_progress.sh 
sh all_coins_progress.sh
sh trade_amount.sh 

