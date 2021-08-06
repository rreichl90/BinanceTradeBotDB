#!/bin/bash
set -e


echo
echo "### Current to Target Coin Ratio"
echo "\`current_coin_ratio.sh\`"
echo

echo "Date|Current|Target|Ratio"
echo "---|---|---|---"

sqlite3 ../../crypto_trading.db <<EOF
SELECT
  MAX(SH.DATETIME),
  P.FROM_COIN_ID,
  P.TO_COIN_ID,
  ROUND(
    (
      (
        (
          (
            (CURRENT_COIN_PRICE / OTHER_COIN_PRICE) - 0.001 * 5 * (CURRENT_COIN_PRICE / OTHER_COIN_PRICE)
          ) / SH.TARGET_RATIO
        ) -1
      ) * 100
    ),
    2
  ) AS 'RATIO_DICT'
FROM
  SCOUT_HISTORY SH
  JOIN PAIRS P ON P.ID = SH.PAIR_ID
WHERE
  PAIR_ID IN (
    SELECT
      DISTINCT ID
    FROM
      PAIRS
    WHERE
      FROM_COIN_ID = (
        SELECT
          ALT_COIN_ID
        FROM
          TRADE_HISTORY
        ORDER BY
          DATETIME DESC
        LIMIT
          1
      )
  )
GROUP BY
  P.TO_COIN_ID
ORDER BY
  RATIO_DICT DESC
EOF

echo

echo "_When ratio goes above zero, the bot will buy it via the bridge coin._"
