#!/bin/bash
# Convert a video to a gif using ffmeg

# check dependencies
if ! command -v ffmpeg &> /dev/null
then
  echo "$(tput setaf 3)Error: Please install ffmpeg"
  exit 1
fi

# set parameters
IN_VIDEO="input.mp4"
OUT_GIF="output.gif"
FPS=30

# parse arguments
if [[ $# -lt 1 ]]; then
cat <<EOF
Usage: $(basename -- $0) input_video [output_gif] [FPS]
EOF
exit 1
fi

[ ! -z $1 ] && IN_VIDEO=$1
[ ! -z $2 ] && OUT_GIF=$2
[ ! -z $3 ] && FPS=$3

# run
set -o xtrace
ffmpeg -i $IN_VIDEO -vf "fps=$FPS,scale=320:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 $OUT_GIF
