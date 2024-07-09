#!/bin/bash

# Navigate to the map directory
cd ./static/map

# Initialize an empty JSON object
json_output="{"

# Function to process primary directories
process_primary_directory() {
  local dir_path="$1"
  local dir_name=$(basename "$dir_path")

  # Initialize a temporary JSON object for the current directory
  local temp_json="\"$dir_name\": {"

  # Find subdirectories
  local subdirs=$(find "$dir_path" -mindepth 1 -maxdepth 1 -type d)

  for subdir in $subdirs; do
    local subdir_name=$(basename "$subdir")
    temp_json+="\"$subdir_name\": ["

    # Find .png files in the current subdirectory
    local files=$(find "$subdir" -maxdepth 1 -type f -name "*.png" | sed 's|^.*/||')

    for file in $files; do
      temp_json+="\"$file\","
    done

    # Remove the trailing comma and close the JSON array
    temp_json="${temp_json%,}]"
    temp_json+=","
  done

  # Remove the trailing comma and close the JSON object for the current directory
  temp_json="${temp_json%,}},"
  json_output+="$temp_json"
}

# Process the primary directories (overworld, the_nether, etc.)
for primary_dir in */ ; do
  process_primary_directory "$primary_dir"
done

# Remove the trailing comma and close the main JSON object
json_output="${json_output%,}}"

# Write the JSON output to the map-files.json file
echo "$json_output" > ../map-files.json

# Print a message indicating the script has completed
echo "map-files.json has been created in the ./static/ directory."
