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

IN_VIDEO="$1"

if [ ! -f "$IN_VIDEO" ]; then
  echo "Error: File '$IN_VIDEO' doesn't exist."
  exit 1
fi

OUT_AUDIO="${IN_VIDEO%.*}.m4a"

# run
set -o xtrace
ffmpeg -i "$IN_VIDEO" -vn -acodec aac $OUT_AUDIO
