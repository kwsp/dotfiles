#!/usr/bin/env bash
# Finds all files in the current directory for files of type 'HEIC'
# and converts them to jpeg formats.
if ! command -v convert &> /dev/null
then
  echo "$(tput setaf 3)Error: Please install ImageMagick"
  exit 1
fi

convert2jpeg () {
  local name=$1
  local filename=$(basename -- "$name")
  local filename="${filename%.*}"
  local newname="$filename.jpeg"
  convert "$name" "$newname"
}


# no. of heic files (to calculate progress correctly)
n=$(ls -l *.heic *.HEIC 2>/dev/null | wc -l | sed 's/ //g')
if [ $n = 0 ]; then
  echo "$(tput setaf 1)No HEIC files found."
fi

i=0
# Redirect error to /dev/null since *.HEIC files may not exist and will print a message.
ls *.heic *.HEIC 2>/dev/null | while read name
do
  percent=$(((i*100)/(n)))
  echo "\033[2K[$percent%] Converting $name                          \r\c"
  i=$((i+1))

  convert2jpeg "$name" &
done

wait
echo "$(tput setaf 2)✨ Converted $n files from heic to jpeg. Please manually remove heic files if you wish."
