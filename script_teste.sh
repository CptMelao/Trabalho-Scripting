#!/bin/bash

# specify the URL of the webpage to scrape
url="https://www.auto-data.net/en/porsche-carrera-gt-5.7-i-v10-40v-612hp-6692"

# download the webpage
content=$(curl -s "$url")

# extract the contents of all <tr> tags
trs=$(echo "$content" | sed -n 's/.*<tr[^>]*>\(.*\)<\/tr>.*/\1/p')

# extract the contents of all <th> tags
ths=$(echo "$trs" | sed -n 's/.*<th[^>]*>\(.*\)<\/th>.*/\1/p')

# extract the contents of all <td> tags
tds=$(echo "$trs" | sed -n 's/.*<td[^>]*>\(.*\)<\/td>.*/\1/p')

# print the extracted content
echo "trs: $trs"
echo "ths: $ths"
echo "tds: $tds"