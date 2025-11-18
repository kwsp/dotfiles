#!/bin/bash
# Convert a video to audio (AAC) using ffmpeg
set -e

# check dependencies
if ! command -v ffmpeg &>/dev/null; then
  echo "$(tput setaf 3)Error: Please install ffmpeg"
  exit 1
fi

# parse arguments
if [[ $# -lt 1 ]]; then
  cat <<EOF
Usage: $(basename -- $0) input_video
EOF
  exit 1
fi

input_file="$1"
if [ ! -f "$input_file" ]; then
  echo "Error: File '$input_file' doesn't exist."
  exit 1
fi

output_file="${input_file%.*}.m4a"

# run
set -x
ffmpeg -i "${input_file}" -vn -acodec aac "${output_file}"
