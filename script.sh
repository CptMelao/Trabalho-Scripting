#!/bin/bash

# File containing URLs to scrape
file="./urls.txt"

# CSV file to save the scraped data
csv_file="./scraped_data.csv"

# Create the CSV file and add a header row
echo "URL,Content" > $csv_file

# Loop through each line in the file
while read -r line; do
  # Use curl to download the HTML from the URL
  html=$(curl -s "$line")

  # Use grep to search for URLs in the HTML
  scraped_urls=$(echo "$html" | grep -o 'https*://[^"]*')

  # Save the scraped data to the CSV file
  echo "$line,$scraped_urls" >> $csv_file
done < "$file"