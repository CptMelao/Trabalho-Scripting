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
  td_text=$(echo "$row" | sed 's/<[^>]*>//g')
  if [ $i -eq 0 ]; then
    i=1
    continue
  fi
  # Write the th cell, td text,td_quote, and val2 data to the CSV file
  echo "$td_text" >> $csv_file
done <<< "$rows"