#!/bin/bash

# specify the URL of the webpage to scrape
url="https://www.auto-data.net/en/porsche-carrera-gt-5.7-i-v10-40v-612hp-6692"

# CSV file to save the scraped data
csv_file="./scraped_data.csv"

# Create the CSV file
touch $csv_file

# Download the HTML from the URL
html=$(curl -s "$url")

# Extract the table body
table_body=$(echo "$html" | sed -n '/<tbody>/,/<\/tbody>/p')

# Extract the table headers
headers=$(echo "$table_body" | grep -o '<strong>.*</strong>' | sed 's/<[^>]*>//g')

# Add the headers to the CSV file
echo "$headers" > $csv_file

# Extract the table rows
rows=$(echo "$table_body" | sed -n '/<tr>/,/<\/tr>/p' | sed 's/<ins[^>]*>//g' | sed 's/<[^>]*>//g')

# Loop through each row
while read -r row; do
  # Split the row into columns
  IFS=' ' read -ra columns <<< "$row"

  # Write the columns to the CSV file
  echo "${columns[*]}" >> $csv_file
done <<< "$rows"