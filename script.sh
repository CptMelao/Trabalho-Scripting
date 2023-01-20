#!/bin/bash

# File containing URLs to scrape
file="./urls.txt"

# CSV file to save the scraped data
csv_file="./scraped_data.csv"

# Create the CSV file and add a header row
echo "URL,Title,Description,Keywords" > $csv_file

# Loop through each line in the file
while read -r line; do
  # Use curl to download the HTML from the URL
  html=$(curl -s "$line")

  # Extract the title, description and keywords
  title=$(echo "$html" | grep -o '<title>.*</title>' | sed 's/<title>//' | sed 's/<\/title>//')
  description=$(echo "$html" | grep -o '<meta name="description" content=".*">' | sed 's/<meta name="description" content="//' | sed 's/">//')
  keywords=$(echo "$html" | grep -o '<meta name="keywords" content=".*">' | sed 's/<meta name="keywords" content="//' | sed 's/">//')

  # Save the scraped data to the CSV file
  echo "$line,$title,$description,$keywords" >> $csv_file
done < "$file"