#!/bin/bash
# Convert all images to webp
set -e

# check dependencies
if ! command -v magick &>/dev/null; then
  echo "$(tput setaf 3)Error: Please install magick"
  exit 1
fi

files=$(find . -type f \( -iname "*.jpeg" -o -iname "*.jpg" -o -iname "*.png" \))

echo "The following files will be converted to WebP:"
echo "$files"

MAX_JOBS=4 # max concurrent jobs

# Ask for confirmation
read -p "Proceed with conversion? [y/N] " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
  echo "$files" | while IFS= read -r f; do

    # wait if we're at max capacity
    while [ $(jobs -r | wc -l) -ge $MAX_JOBS ]; do
      sleep 0.1
    done

    out="${f%.*}.webp"
    echo "Converting $f -> $out"
    magick "$f" "$out" &
  done
else
  echo "Aborted."
fi
