#!/bin/bash
set -e

DATE_STRING="$(date '+%A %d-%B-%Y at %T')"
MD_FULL_PATH=README.md

echo "Generated on \`${DATE_STRING}\`" > ${MD_FULL_PATH}

sh scripts/backup_hassio_binance_db.sh >> ${MD_FULL_PATH}

echo "" >> ${MD_FULL_PATH}
echo "## See [here for beginners instructions](INSTRUCTIONS.md)" >> ${MD_FULL_PATH}
echo "" >> ${MD_FULL_PATH}