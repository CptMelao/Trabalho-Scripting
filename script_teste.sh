#!/bin/bash

# specify the URL of the webpage to scrape
url="https://www.auto-data.net/en/nissan-primera-p10-2.0-gt-150hp-639"
# https://www.auto-data.net/en/porsche-carrera-gt-5.7-i-v10-40v-612hp-6692
# https://www.auto-data.net/en/nissan-primera-p10-2.0-gt-150hp-639

# CSV file to save the scraped data
csv_file="./output.csv"

# Create the CSV file
touch $csv_file

# Download the HTML from the URL
html=$(curl -s "$url")

# Extract the specific table
table=$(echo "$html" | sed -n '/<table[^>]*class="cardetailsout car2"[^>]*>/,/<\/table>/p')

# Extract the table headers
headers=$(echo "$table" | grep -o '<th>.*</th>' | sed 's/<[^>]*>//g')

# Add the headers to the CSV file
echo "$td_text" > $csv_file

# Extract the table rows
rows=$(echo "$table" | sed -n '/<tr>/,/<\/tr>/p')

# Loop through each row
i=0
while read -r row; do
  # Extract the th cell
  #th=$(echo "$row" | grep -o '<th>.*</th>' | sed 's/<[^>]*>//g')
  # Extract the td cells
  #td=$(echo "$row" | grep -o '<td>.*</td>' | sed 's/<[^>]*>//g')
  # Extract the text inside the td cells
  td_text=$(echo "$row" | sed 's/<[^>]*>//g')
  # Extract the text inside quotation marks inside the <td> tag
  #td_quote=$(echo "$td" | grep -o '".*"' | sed 's/"//g')
  # Extract the data from the <span class="val2"> tag
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
  echo "$td_text" >> $csv_file
done <<< "$rows"
