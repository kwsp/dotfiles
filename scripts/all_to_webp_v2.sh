#!/bin/bash
# Convert all images to webp with optional output directory
set -e

# check dependencies
if ! command -v magick &>/dev/null; then
  echo "$(tput setaf 3)Error: Please install magick"
  exit 1
fi

# Parse optional output directory argument
output_dir=""
if [ $# -ge 1 ]; then
  output_dir="$1"
  # Create output directory if it doesn't exist
  mkdir -p "$output_dir"
fi

files=$(find . -type f \( -iname "*.jpeg" -o -iname "*.jpg" -o -iname "*.png" \))

if [ -z "$files" ]; then
  echo "No image files found."
  exit 0
fi

echo "The following files will be converted to WebP:"
echo "$files"

if [ -n "$output_dir" ]; then
  echo ""
  echo "Output directory: $output_dir"
fi

MAX_JOBS=4 # max concurrent jobs

# Ask for confirmation
read -p "Proceed with conversion? [y/N] " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
  echo "$files" | while IFS= read -r input_file; do

    # wait if we're at max capacity
    while [ $(jobs -r | wc -l) -ge $MAX_JOBS ]; do
      sleep 0.1
    done

    # Determine output file path
    if [ -n "$output_dir" ]; then
      # Use output directory with just the filename
      filename=$(basename "$input_file")
      output_file="${output_dir}/${filename%.*}.webp"
    else
      # Same directory as original (default behavior)
      output_file="${input_file%.*}.webp"
    fi

    echo "Converting $input_file -> $output_file"
    magick "$input_file" "$output_file"

    # Set the modification time of the new file to be the same as the original
    touch -t $(stat -f "%SB" -t "%Y%m%d%H%M.%S" "$input_file") "$output_file"
  done
else
  echo "Aborted."
fi
