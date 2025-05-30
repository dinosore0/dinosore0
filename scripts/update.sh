#!/bin/bash

# Set script directory and navigate to it
# SCRIPT_DIR="$(dirname "$(realpath "$0")")"
# cd "$SCRIPT_DIR"

# cd ../..

# Pull the latest changes from the repository
# git pull
git config user.name "dino"
git config user.email "cuongtruong2015@gmail.com"
git pull
# Define file paths and start date
TEMPLATE_FILE="template.md"
README_FILE="README.md"
START_DATE="03/09/2022"

# Copy the template to the README file
cp "$TEMPLATE_FILE" "$README_FILE"

# Fetch advice from the FavQs API
echo "................FECTCHING ADVICE............."
ADVICE=$(curl -s https://favqs.com/api/qotd | jq -r '.quote.body')  

while [ "$ADVICE" = "null" ];
do
  echo "................FECTCHING ADVICE............."
  ADVICE=$(curl -s https://favqs.com/api/qotd | jq -r '.quote.body');
done

# Update the README file with the fetched advice
sed -i "s/###Brief tip or insight###/$ADVICE/" "$README_FILE"
echo "$ADVICE"
echo "................DONE............."
# Calculate the number of days since the start date
start_date_epoch=$(date -d "$START_DATE" +%s)
current_date_epoch=$(date +%s)
days_elapsed=$(( (current_date_epoch - start_date_epoch) / 86400 ))

# Update the README file with the number of days elapsed
sed -i "s/###Experienced days###/($days_elapsed days)/" "$README_FILE"
echo "Updated $days_elapsed days in the file"

# Commit the changes and push to the repository
git add "$README_FILE"
git commit -m "Update days and tips"
git push

