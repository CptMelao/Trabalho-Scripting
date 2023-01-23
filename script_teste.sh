#!/bin/bash

# specify the URL of the webpage to scrape
url="https://www.auto-data.net/en/porsche-carrera-gt-5.7-i-v10-40v-612hp-6692"

# download the webpage
content=$(curl -s "$url")

# extract the contents of the specified tag
specified_tag=$(echo "$content" | sed -n '/<table class="cardetailsout car2">/,/<\/div>/p')

# extract the contents of every tag inside the specified tag
tags=$(echo "$specified_tag" | sed 's/<[^>]*>//g')

# print the extracted content
echo "$tags" > output.csv
