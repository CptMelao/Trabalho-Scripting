wget -q -O - 'https://www.auto-data.net/en/porsche-carrera-gt-5.7-i-v10-40v-612hp-6692' |\
  xmlstarlet format --recover --html 2>/dev/null |\
  xmlstarlet select --html --template --value-of "/html/body/div/table/tbody/tr/td[@class='listing0' or @class='listing' or @class='listing ']" |\
  paste -d ";" - - - - - |\
  column -s ";" -t
