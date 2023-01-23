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

# Extract the table headers
headers=$(echo "$table" | grep -o '<th[^>]*>.*</th>' | sed 's/<[^>]*>//g' | tr '\n' ',' | sed 's/,$//')

# Add the headers to the CSV file
echo "$headers" > $csv_file

# Extract the table rows
rows=$(echo "$table" | grep -o '<tr[^>]*>.*</tr>' | sed 's/<[^>]*>//g' | tr '\n' ',' | sed 's/,$//')

# Loop through each row
while read -r row; do
  # Write the row to the CSV file
  echo "$row" >> $csv_file
done <<< "$rows"