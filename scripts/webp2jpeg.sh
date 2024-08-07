#!/usr/bin/env bash
# Finds all files in the current directory for files of type 'Web/P'
# and converts them to jpeg formats.
if ! command -v convert &> /dev/null
then
  echo "$(tput setaf 3)Error: Please install ImageMagick"
  exit 1
fi

n=$(ls -l *.webp *.WEBP | wc -l | sed 's/ //g')
if [ $n = 0 ]; then
  echo "$(tput setaf 1)No webp files found."
fi

i=0
ls *.webp *.WEBP | while read name
do
  percent=$(((i*100)/(n)))
  filename=$(basename -- "$name")
  filename="${filename%.*}"
  newname="$filename.jpeg"
  echo "[$percent%] Converting $name                          \r\c"
  convert "$name" "$newname" &
  i=$((i+1))
done

wait
echo "$(tput setaf 2)✨ Converted $n files from webp to jpeg. Please manually remove webp files if you wish."
