#!/bin/bash
# Convert all images to webp
# Arguments will be forward to the magick command
set -e

# check dependencies
if ! command -v magick &>/dev/null; then
  echo "$(tput setaf 3)Error: Please install magick"
  exit 1
fi

files=$(find . -maxdepth 1 -type f \( -iname "*.jpeg" -o -iname "*.jpg" -o -iname "*.png" \))
file_count=$(wc -l < <(echo "$files"))

echo "The following $file_count files will be converted to WebP with arguments $@"
echo "$files"

# Ask for confirmation
read -p "Proceed with conversion? [y/N] " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
  converted=0
  failed=0
  while read -r input_file; do

    output_file="${input_file%.*}.webp"
    if magick "$input_file" "$@" "$output_file"; then
      # Set the modification time of the new file to be the same as the original
      touch -t $(stat -f "%SB" -t "%Y%m%d%H%M.%S" "$input_file") "$output_file"
      echo "Converted: $input_file -> $output_file"
      ((converted++))
    else
      echo "Failed: $input_file -> $output_file"
      ((failed++))
    fi
  done < <(echo "$files")

  echo "Complete. Successfully converted: $converted file(s)"
  [ "$failed" -gt 0 ] && echo "Failed $failed file(s)"
else
  echo "Aborted."
fi
