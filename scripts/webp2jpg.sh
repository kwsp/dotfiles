#!/bin/sh
# Finds all files in the current directory for files of type 'Web/P'
# and converts them to jpg formats.
if ! command -v convert &> /dev/null
then
  echo "$(tput setaf 3)Error: Please install ImageMagick"
  exit 1
fi

i=0
n=$(ls -l *.webp | wc -l | sed 's/ //g')
ls *.webp | while read name
do
  percent=$(((i*100)/(n)))
  filename=$(basename -- "$name")
  filename="${filename%.*}"
  newname="$filename.jpg"
  echo "[$percent%] Converting $name                          \r\c"
  convert "$name" "$newname"
  i=$((i+1))
done

echo "$(tput setaf 2)✨ Converted $n files from webp to jpg. Please manually remove webp files if you wish."
