#!/usr/bin/env bash

cd "$(dirname "$0")/../data"

# updated At
json_count() {
  jq -e -r "$2 | if type == \"array\" then length else 0 end" "$1" 2>/dev/null || printf '0\n'
}

# sources
jq -n \
  --arg dt "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
  --argjson doji "$(json_count prices-doji.json '.')" \
  --argjson phuquy "$(json_count prices-phuquy.json '.data')" \
  --argjson baotinmanhhai "$(json_count prices-baotinmanhhai.json '.data.goldRates.items')" \
  --argjson baotinminhchau "$(json_count prices-baotinminhchau.json '.sources')" \
  --argjson ngoctham "$(json_count prices-ngoctham.json '.chitiet')" \
  '{
    updatedAt: $dt,
    sources: {
      goldprice: 2,
      doji: $doji,
      phuquy: $phuquy,
      baotinmanhhai: $baotinmanhhai,
      baotinminhchau: $baotinminhchau,
      ngoctham: $ngoctham
    }
  }' > info.json

# clean json files, if they are empty file write '{}'
for f in prices-*.json; do
  if [ ! -s "$f" ]; then
    echo '{}' > "$f"
  fi
done
