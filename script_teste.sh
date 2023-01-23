#!/bin/bash

# specify the URL of the webpage to scrape
url="https://www.auto-data.net/en/porsche-carrera-gt-5.7-i-v10-40v-612hp-6692"

# CSV file to save the scraped data
csv_file="./output.csv"

# Create the CSV file
touch $csv_file

# Download the HTML from the URL
html=$(curl -s "$url")

# Extract the table with class cardetailsout car2
table=$(echo "$html" | sed -n '/<table class="cardetailsout car2">/,/<\/table>/p')

# Extract the <strong> tag
strong_tag=$(echo "$table" | grep -o '<strong>.*</strong>' | sed 's/<[^>]*>//g')

# Extract the table headers
headers=$(echo "$table" | grep -o '<th[^>]*>.*</th>' | sed 's/<[^>]*>//g')

# Extract the table rows
rows=$(echo "$table" | grep -o '<tr[^>]*>.*</tr>' | sed 's/<[^>]*>//g')

# Add the headers and strong_tag to the CSV file as the first row
echo "strong_tag, headers, rows" > $csv_file

# Loop through each row
while read -r row; do
  # Split the row into columns
  IFS=' ' read -ra columns <<< "$row"

  # Write the columns to the CSV file
  echo "$strong_tag, $headers, ${columns[*]}" >> $csv_file
done <<< "$rows"