#!/bin/bash

# File containing URLs to scrape
file="./urls.txt"

# CSV file to save the scraped data
csv_file="./scraped_data.csv"

# Create the CSV file and add a header row
echo "Column1,Column2,Column3" > $csv_file

# Download the HTML from the URL
html=$(curl -s "$url")

# Use grep and sed to extract the table rows
rows=$(echo "$html" | grep -o '<tr>.*</tr>' | sed 's/<[^>]*>//g')

# Loop through each row
while read -r row; do
  # Split the row into columns
  IFS=',' read -ra columns <<< "$row"
  column1="${columns[0]}"
  column2="${columns[1]}"
  column3="${columns[2]}"

  # Save the scraped data to the CSV file
  echo "$column1,$column2,$column3" >> $csv_file
done <<< "$rows"