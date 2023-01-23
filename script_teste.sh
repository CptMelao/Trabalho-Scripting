
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
table_body=$(echo "$html" | sed -n '/<tbody>/,/<\/tbody>/p')

# Extract the table headers
headers=$(echo "$table_body" | grep -o '<strong>.*</strong>' | sed 's/<[^>]*>//g')

# Add the headers to the CSV file
echo "$headers" > $csv_file

# Extract the table rows
rows=$(echo "$table_body" | sed -n '/<tr>/,/<\/tr>/p' | sed 's/<ins[^>]*>.*<\/ins>//g' | sed 's/<div class="ad_incar">.*<\/div>//g'| sed 's/<caption>.*<\/caption>//g' | sed 's/<h2 class="car">.*<\/h2>//g'| sed 's/<[^>]*>//g')

# Declare a variable to hold the current <strong> tag
current_strong=""

# Loop through each row
while read -r row; do
  # Split the row into columns
  IFS=' ' read -ra columns <<< "$row"

  # Check if the current row contains a <strong> tag
  if [[ $row =~ "<strong>" ]]; then
    current_strong=$(echo "$row" | grep -o '<strong>.*</strong>' | sed 's/<[^>]*>//g')
  fi

  # Write the current <strong> tag, the headers and the <td> tags to the CSV file
  echo "$current_strong, ${columns[*]}" >> $csv_file
done <<< "$rows"