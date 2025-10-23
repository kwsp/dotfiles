#!/bin/bash
# Convert a video to a gif using ffmeg
set -e

# check dependencies
if ! command -v ffmpeg &>/dev/null; then
  echo "$(tput setaf 3)Error: Please install ffmpeg"
  exit 1
fi

# parse arguments
if [[ $# -lt 1 ]]; then
  cat <<EOF
Usage: $(basename -- $0) input_video [FPS]
EOF
  exit 1
fi

IN_VIDEO="$1"
FPS=10
[ ! -z "$2" ] && FPS="$3"

if [ ! -f "$IN_VIDEO" ]; then
  echo "Error: File '$IN_VIDEO' doesn't exist."
  exit 1
fi

OUT_GIF="${IN_VIDEO%.*}.gif"

# run
set -o xtrace
ffmpeg -i "$IN_VIDEO" \
  -vf "fps=$FPS,scale=480:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
  -loop 0 "$OUT_GIF"
