#!/bin/bash
# Convert video to HEVC video codec, AAC audio codec, and mp4 container

# Check for parameter
if [ $# -lt 1 ] || [ $# -gt 2 ]; then
  echo "Error: Please provide one or two parameters."
  echo "Usage: $0 input_file [output_file]"
  exit 1
fi

# Validate input file
input_file="$1"
if [ ! -f "$input_file" ]; then
  echo "Error: File '$input_file' doesn't exist."
  exit 1
fi

# Get video and audio codec information
video_codec=$(ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "$input_file")
audio_codec=$(ffprobe -v error -select_streams a:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "$input_file")
if [ $? -ne 0 ]; then
  echo "Error: Could not analyze video file '$input_file'"
  exit 1
fi

echo "Video codec: $video_codec"
echo "Audio codec: $audio_codec"

# Determine video conversion strategy
if [[ "$video_codec" == "hevc" ]]; then
  video_args="-c:v copy"
  echo "Video: HEVC, copying without re-encoding"
elif [[ "$video_codec" == "av1" ]]; then
  video_args="-c:v copy"
  echo "Video: AV1, copying without re-encoding"
else
  # video_args="-c:v libx265 -q:v 65 -vtag hvc1"
  video_args="-c:v libx265 -crf 23 -preset medium -vtag hvc1"
  echo "Video: Converting to HEVC"
fi

# Determine audio conversion strategy
if [[ "$audio_codec" == "aac" ]]; then
  audio_args="-c:a copy"
  echo "Audio: AAC, copying without re-encoding"
else
  audio_args="-c:a aac -b:a 192k"
  echo "Audio: converting to AAC"
fi

# Generate output filename
if [[ $# -eq 2 ]]; then
  output_file="$2"
else
  # If existing extension is .mp4, add _ to basename
  base_name=$(basename "$input_file")
  dir_part=$(dirname "$input_file")
  base_name_no_ext="${base_name%.*}"
  old_extension=".${base_name##*.}"
  if [ "$old_extension" = ".mp4" ]; then
    base_name_no_ext="${base_name_no_ext}_"
  fi
  output_file="${dir_part}/${base_name_no_ext}.mp4"
fi

# Convert the video
echo "Converting '$input_file' to '$output_file'"
ffmpeg -i "$input_file" -map_metadata 0 $video_args $audio_args "$output_file"

# Check if ffmpeg succeeded
if [ $? -ne 0 ]; then
  echo "Error: ffmpeg conversion failed."
  exit 1
fi

echo "Conversion completed successfully!"
tput bel
