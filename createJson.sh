#!/bin/bash

# Define the directory containing the files
map_dir="./static/map/"
output_file="./static/map-files.json"

# Check if the directory exists
if [ ! -d "$map_dir" ]; then
  echo "Directory $map_dir does not exist."
  exit 1
fi

# Get all filenames in the directory
filenames=$(ls "$map_dir")

# Convert filenames to JSON array format
json_array=$(printf '%s\n' "$filenames" | jq -R . | jq -s .)

# Write the JSON array to the output file
echo "$json_array" > "$output_file"

echo "Filenames have been listed in $output_file."
