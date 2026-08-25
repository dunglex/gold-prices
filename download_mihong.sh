#!/usr/bin/env bash

cd "$(dirname "$0")/data"

# Download gold prices from mihong.vn
echo "Downloading https://api.mihong.vn/v1/gold-prices?market=domestic"
curl --connect-timeout 5 -k 'https://api.mihong.vn/v1/gold-prices?market=domestic' \
  -H 'accept: */*' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'dnt: 1' \
  -H 'origin: https://www.mihong.vn' \
  -H 'pragma: no-cache' \
  -H 'priority: u=1, i' \
  -H 'referer: https://www.mihong.vn/' \
  -H 'sec-ch-ua: "Not;A=Brand";v="8", "Chromium";v="150", "Google Chrome";v="150"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-site' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36' \
  -H 'x-market: mihong' > prices_mihong.json
