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

# Find all image files and filter those that need conversion
files_to_convert=""
while IFS= read -r input_file; do
  # Determine output file path
  if [ -n "$output_dir" ]; then
    filename=$(basename "$input_file")
    output_file="${output_dir}/${filename%.*}.webp"
  else
    output_file="${input_file%.*}.webp"
  fi

  # Check if conversion is needed:
  # 1. webp file doesn't exist, OR
  # 2. webp file and original have different mtime
  if [ ! -f "$output_file" ] || [ "$input_file" -nt "$output_file" ] || [ "$input_file" -ot "$output_file" ]; then
    # Store both input and output file paths (tab-separated)
    if [ -z "$files_to_convert" ]; then
      files_to_convert="${input_file}\t${output_file}"
    else
      files_to_convert="${files_to_convert}\n${input_file}\t${output_file}"
    fi
  fi
done < <(find . -type f \( -iname "*.jpeg" -o -iname "*.jpg" -o -iname "*.png" \))

if [ -z "$files_to_convert" ]; then
  echo "No image files need conversion (all webp files are up to date)."
  exit 0
fi

echo "The following files will be converted to WebP:"
echo -e "$files_to_convert" | while IFS=$'\t' read -r input_file output_file; do
  echo "  $input_file -> $output_file"
done

if [ -n "$output_dir" ]; then
  echo ""
  echo "Output directory: $output_dir"
fi

MAX_JOBS=4 # max concurrent jobs

# Ask for confirmation
read -p "Proceed with conversion? [y/N] " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
  echo -e "$files_to_convert" | while IFS=$'\t' read -r input_file output_file; do

    # wait if we're at max capacity
    while [ $(jobs -r | wc -l) -ge $MAX_JOBS ]; do
      sleep 0.1
    done

    echo "Converting $input_file -> $output_file"
    magick "$input_file" "$output_file"

    # Set the modification time of the new file to be the same as the original
    touch -r "$input_file" "$output_file"
  done
else
  echo "Aborted."
fi
