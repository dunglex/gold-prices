#!/usr/bin/env bash

cd "$(dirname "$0")/../data"

# Download gold prices from GoldPrice.org
echo "Downloading https://data-asg.goldprice.org/dbXRates/USD"
curl --connect-timeout 5 -k 'https://data-asg.goldprice.org/dbXRates/USD' \
  -H 'accept: */*' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H 'cache-control: no-cache' \
  -H 'origin: https://goldprice.org' \
  -H 'pragma: no-cache' \
  -H 'priority: u=1, i' \
  -H 'referer: https://goldprice.org/' \
  -H 'sec-ch-ua: "Not;A=Brand";v="8", "Chromium";v="150", "Google Chrome";v="150"' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36' > prices-goldprice.json

# Download gold prices from Doji
echo "Downloading https://banggia.doji.vn/api/TablePrice/GetTablePrice"
curl --connect-timeout 5 -k 'https://banggia.doji.vn/api/TablePrice/GetTablePrice' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en-US,en;q=0.9,cs;q=0.8' \
  -H 'Authorization: Bearer null' \
  -H 'Connection: keep-alive' \
  -H 'Referer: https://banggia.doji.vn/gold-price' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0' \
  -H 'sec-ch-ua: "Not;A=Brand";v="8", "Chromium";v="150", "Microsoft Edge";v="150"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' > prices-doji-encrypted.json

# Download prices from phuquy.com.vn
echo "Downloading https://be.phuquy.com.vn/jewelry/product-payment-service/api/products/get-price"
curl --connect-timeout 5 -k 'https://be.phuquy.com.vn/jewelry/product-payment-service/api/products/get-price' \
  -H 'accept: application/json, text/plain, */*' \
  -H 'accept-language: vi-VN' \
  -H 'dnt: 1' \
  -H 'origin: https://phuquy.com.vn' \
  -H 'priority: u=1, i' \
  -H 'referer: https://phuquy.com.vn/' \
  -H 'sec-ch-ua: "Not;A=Brand";v="8", "Chromium";v="150", "Google Chrome";v="150"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-site' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36' > prices-phuquy.json

# Download prices from baotinmanhhai.vn
echo "Downloading https://baotinmanhhai.vn/api/graphql"
curl --connect-timeout 5 -k 'https://baotinmanhhai.vn/api/graphql' \
  -H 'accept: application/graphql-response+json, application/json' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H 'content-type: application/json' \
  -H 'origin: https://baotinmanhhai.vn' \
  -H 'priority: u=1, i' \
  -H 'referer: https://baotinmanhhai.vn/vi/bang-gia-vang' \
  -H 'sec-ch-ua: "Not;A=Brand";v="8", "Chromium";v="150", "Google Chrome";v="150"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'store: default' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36' \
  --data-raw '{"query":"\n  query GetGoldRates {\n    goldRates {\n      items {\n        code\n        name\n        vendor_name\n        buy_price\n        sell_price\n        unit\n        weight\n        trend\n        trend_value\n        sparkline_data\n        sell_sparkline_data\n        last_updated\n        rate_image\n      }\n      total_count\n      ticker_config {\n        selected_products\n        max_items\n        cta_label\n        cta_url\n        link_label\n        link_url\n        ticker_media\n        logo\n      }\n    }\n  }\n","operationName":"GetGoldRates"}' -k > prices-baotinmanhhai.json

 # Download ngoctham.com
 echo "Downloading https://ngoctham.com/ajax/proxy_banggia.php"
 curl --connect-timeout 5 -k 'https://ngoctham.com/ajax/proxy_banggia.php' \
  -H 'accept: */*' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H 'cache-control: no-cache' \
  -H 'pragma: no-cache' \
  -H 'priority: u=1, i' \
  -H 'referer: https://ngoctham.com/bang-gia-vang/' \
  -H 'sec-ch-ua: "Not;A=Brand";v="8", "Chromium";v="150", "Google Chrome";v="150"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36' -k > prices-ngoctham.json
