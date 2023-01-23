#!/bin/bash

# specify the URL of the webpage to scrape
url="https://www.auto-data.net/en/porsche-carrera-gt-5.7-i-v10-40v-612hp-6692"

# CSV file to save the scraped data
csv_file="./output.csv"

# Create the CSV file
touch $csv_file

# Download the HTML from the URL
html=$(curl -s "$url")

# Extract the table body
table_body=$(echo "$html" | sed -n '/<tbody>/,/<\/tbody>/p' | sed -n '/<tr>/,/<\/tr>/p;/<th>/,/<\/th>/p;/<td>/,/<\/td>/p;/<a>/,/<\/a>/p' | sed 's/<[^>]*>//g')

# Extract the table headers
headers=$(echo "$table_body" | grep -o '<th[^>]*>.*</th>')

# Add the headers to the CSV file
echo "$headers" > $csv_file

# Extract the table rows
rows=$(echo "$table_body" | grep -o '<tr[^>]*>.*</tr>' | grep -o '<td[^>]*>.*</td>\|<a[^>]*href[^>]*>.*</a>')

# Loop through each row
while read -r row; do
  # Split the row into columns
  IFS=' ' read -ra columns <<< "$row"

  # Write the columns to the CSV file
  echo "${columns[*]}" >> $csv_file
done <<< "$rows"