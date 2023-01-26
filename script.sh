#!/bin/bash

# specify the URL of the webpage to scrape
url="https://www.auto-data.net/en/nissan-primera-p10-2.0-gt-150hp-639"
# https://www.auto-data.net/en/porsche-carrera-gt-5.7-i-v10-40v-612hp-6692
# https://www.auto-data.net/en/nissan-primera-p10-2.0-gt-150hp-639

# CSV file to save the scraped data
csv_file="./scraped_data.csv"

# Create the CSV file
touch $csv_file

# Download the HTML from the URL
html=$(curl -s "$url")

# Extract the specific table
table=$(echo "$html" | sed -n '/<table[^>]*class="cardetailsout car2"[^>]*>/,/<\/table>/p')

# Add the headers to the CSV file
echo "Info, Specs, Specs2" > $csv_file

# Extract the table rows
rows=$(echo "$table" | sed -n '/<tr>/,/<\/tr>/p')

# Loop through each row
i=0
while read -r row; do
  # Extract the th cell
  th=$(echo "$row" | grep -o '<th>.*</th>' | sed 's/<[^>]*>//g')
  #th=$(echo "$row" | grep -o '<th>.*</th>' | sed 's/<[^>]*>//g' | sed ':a; N; s/[[:space:]]//g; ta')
  # Extract the td cells
  #td=$(echo "$row" | grep -o '<td>.*</td>' | sed 's/<td>\(.*\)<\/td>/\1/g' | sed 's/"//g')
  td=$(echo "$row" | grep -o '<td>.*</td>' | sed 's/<[^>]*>//g')
  #td=$(echo "$row" | sed -n 's:.*<td>\(.*\)</td>.*:\1:p' | sed -r 's/([0-9])([a-zA-Z])/\1 \2/g; s/([a-zA-Z])([0-9])/\1 \2/g')
  #td=$(echo "$row" | grep -o "<td>\(.*\)<span class="val2">" | grep -o "<span class="val2">\(.*\)</span class="val2">" | sed 's/<[^>]*>//g')
  #td=($(echo "$row" | grep -oP '(?<=<td><a>)[^<]+' | sed 's/<[^>]*>//g' | sed 's/[^A-Za-z0-9,.!? ] /\n/g'))
  # Extract the text inside the td cells
  #td_q=$(echo "$td" | grep -o "<td>.* <span class="val2">" | sed 's/<[^>]*>//g' | grep -o '".* "' | sed 's/"//g')
  #td_text=$(echo "$td" | sed -n 's:.*<td>\(.*\)</td>.*:\1:p' | grep -o '".* "' | sed 's/"//g')
  #td_text=$(echo "$row" | sed 's/<[^>]*>//g')
  #td_text=$(echo "$row" | sed -n 's:.*<td>\(.*\)</td>.*:\1:p' | sed 's/<[^>]>//g')
  # Extract the text inside quotation marks inside the <td> tag
  #td_quote=$(echo "$td" | grep -o '".*"' | sed 's/"//g')
  # Extract the data from the <span class="val2"> tag
  #val2=$(echo "$row" | sed -n 's:.*<span class="val2">\(.*\)</span>.*:\1:p' | sed 's/<[^>]>//g')
  val2=$(echo "$row" | sed -n 's:.*<span class="val2">\(.*\)</span>.*:\1:p' | sed 's/<br [\/]*>//g' | sed -r 's/([0-9])([a-zA-Z])/\1 \2/g; s/([a-zA-Z])([0-9])/\1 \2/g')
  #val2=$(echo "$row" | grep -o '<span class="val2">.*</span>' | sed 's/<[^>]*>//g')
  # Extract the text inside the <span class="val2"> tag
  #val2_text=$(echo "$val2" | sed 's/<[^>]*>//g')
  # Extract the text inside quotation marks inside the <span class="val2"> tag
  #val2_quote=$(echo "$val2" | grep -o '".*"' | sed 's/\"//g')
  if [ $i -eq 0 ]; then
    i=1
    continue
  fi
  # Write the th cell, td text,td_quote, and val2 data to the CSV file
  echo "$th,$td,$val2" >> $csv_file
done <<< "$rows"