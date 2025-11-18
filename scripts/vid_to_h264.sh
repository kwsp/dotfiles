#!/bin/bash
# Re-encode a video to HEVC using ffmpeg libx265

# Check for parameter
if [ $# -ne 1 ]; then
  echo "Error: Please provide one filename."
  echo "Usage: $0 filename"
  exit 1
fi

# Validate input file
input_file="$1"
if [ ! -f "$input_file" ]; then
  echo "Error: File '$input_file' doesn't exist."
  exit 1
fi

# path parts
dir_part=$(dirname "$input_file")
base_name=$(basename "$input_file")

extension=""
if [[ "$base_name" == *.* ]]; then
  extension=".${base_name##*.}"
  # Remove the extension
  base_name="${base_name%.*}"
fi

new_base_name="${base_name}_avc"
new_filename="${new_base_name}${extension}"
new_full_path="${dir_part}/${new_filename}"

echo "Converting '${input_file}' to '${new_full_path}'"
ffmpeg -i "${input_file}" -c:v libx264 -profile:v high -c:a aac -b:a 128k -vf format=yuv420p "${new_full_path}"
