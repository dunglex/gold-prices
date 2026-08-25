#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")/data"

headers=(
  -H 'accept-language: en-US,en;q=0.9'
  -H 'cache-control: no-cache'
  -H 'pragma: no-cache'
  -H 'priority: u=1, i'
  -H 'sec-ch-ua: "Not;A=Brand";v="8", "Chromium";v="150", "Google Chrome";v="150"'
  -H 'sec-ch-ua-mobile: ?0'
  -H 'sec-ch-ua-platform: "Windows"'
  -H 'sec-fetch-dest: empty'
  -H 'sec-fetch-mode: cors'
  -H 'sec-fetch-site: same-origin'
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'
)

download() {
  local url="$1"
  local output="$2"
  local referer="${3:-}"
  local temporary
  local -a curl_args=(
    --fail --silent --show-error --insecure
    --connect-timeout 15 --max-time 60
    --retry 4 --retry-all-errors --retry-delay 5
    "${headers[@]}"
  )

  temporary=$(mktemp "${output}.tmp.XXXXXX")
  echo "Downloading $url"

  if [[ -n "$referer" ]]; then
    curl_args+=(-H "referer: $referer")
  fi

  if ! curl "${curl_args[@]}" "$url" > "$temporary"; then
    rm -f "$temporary"
    return 1
  fi

  mv "$temporary" "$output"
}

download 'https://btmc.vn/Home/BGiaVang' prices_btmc_vang.html 'https://btmc.vn/'
download 'https://btmc.vn/Home/BGiaBac' prices_btmc_bac.html 'https://btmc.vn/'
