#!/usr/bin/env bash

cd "$(dirname "$0")/../data"

echo "Downloading https://www.sjc.com.vn/GoldPrice/Services/PriceService.ashx"
curl --url 'https://www.sjc.com.vn/GoldPrice/Services/PriceService.ashx' \
  -X 'POST' \
  -H 'accept: */*' \
  -H 'accept-language: en-US,en;q=0.9,cs;q=0.8' \
  -H 'content-length: 0' \
  -b '_gcl_au=1.1.643352842.1786501922; _ga=GA1.1.265636602.1786501922; ASP.NET_SessionId=ca5e7079-90bb-468f-aafe-c56d72031fc7; cf_clearance=oJdMblQ2oyv4MwVpwWPGSg3phRuaVQPuxl2SH.ERGB0-1787648601-1.2.1.1-bErjeu_7KczQTQS57ILvnt9.ZGNtid5ppePbzoPEfrITSnUCRNCnubStIMx7VQZPgvDuVb33qa_oQfLA4us2Mag5G2oXlEq3sQf4e14IWwttyb9fvXLyHUrVvtcO1cvix9M00mZirCFzCFrvOHLDTdUOFKiBvFD.4NZoE_rTCRY9zxDJZ6ZlHcrdJ9nG7R9kcLtafv0MsFPGiLd7CzkYlb52YxM1im1A.MRZnfF0R9r1D.j2G6QWv.FoRryGYZkYzJT99CKxy5WVxsSfKvFpmmlzDTQr19hSLyatcywAXw5251SASrC0Ypg.V0gssVZtY7XIXW77vutoEBOWCWcB57azRrBAa1NM.q5S2xf1.2H2v83.OAEnoRfApJwQnK4vppcOLl8N6I45X..RlvWgawE6yrqsQ7lCT5.hvARDkoQqV3zrGkw2wdbHjqyORQ0bmQI2L2UHmzFApcchgUrXZQ; _ga_JM090DV136=GS2.1.s1787648601$o2$g1$t1787648672$j60$l0$h1723602528' \
  -H 'origin: https://www.sjc.com.vn' \
  -H 'priority: u=1, i' \
  -H 'referer: https://www.sjc.com.vn/' \
  -H 'sec-ch-ua: "Not=A?Brand";v="99", "Microsoft Edge";v="151", "Chromium";v="151"' \
  -H 'sec-ch-ua-arch: "x86"' \
  -H 'sec-ch-ua-bitness: "64"' \
  -H 'sec-ch-ua-full-version: "151.0.4129.93"' \
  -H 'sec-ch-ua-full-version-list: "Not=A?Brand";v="99.0.0.0", "Microsoft Edge";v="151.0.4129.93", "Chromium";v="151.0.7922.138"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-model: ""' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-ch-ua-platform-version: "19.0.0"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0' \
  -H 'x-requested-with: XMLHttpRequest' > prices-sjc.json

# verify result if it is a html page instead of json, then it is an error page
if grep -q '<!DOCTYPE html>' prices-sjc.json; then
  echo "Error: Downloaded content is an HTML page, indicating a possible error."
  echo '{}' > prices-sjc.json
  exit 1
fi