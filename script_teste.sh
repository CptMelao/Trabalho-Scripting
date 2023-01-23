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
echo "$tags" > output.txt

#!/bin/bash

# specify the URL of the webpage to scrape
url="https://www.auto-data.net/en/porsche-carrera-gt-5.7-i-v10-40v-612hp-6692"

# download the webpage and extract the contents of all <tr>, <th> and <td> tags
#content=$(curl -s "$url" | sed -n 's/.*<tr[^>]*>\(.*\)<\/tr>.*/\1/p' | sed -n 's/.*<th[^>]*>\(.*\)<\/th>.*/\1/p' | sed -n 's/.*<td[^>]*>\(.*\)<\/td>.*/\1/p')

# save the extracted content to a CSV file
#echo "$content"

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
echo "$trs, $ths, $tds" > output.txt

