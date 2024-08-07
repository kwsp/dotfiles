#!/bin/sh
if ! command -v convert &> /dev/null
then
  echo "$(tput setaf 3)Error: Please install ImageMagick"
  exit 1
fi

i=0
n=$(ls -l *.png | wc -l | sed 's/ //g')
ls *.png | while read name
do
  percent=$(((i*100)/(n)))
  filename=$(basename -- "$name")
  filename="${filename%.*}"
  newname="$filename.jpg"
  echo "[$percent%] Converting $name                          \r\c"
  convert "$name" "$newname"
  i=$((i+1))
done

echo "$(tput setaf 2)✨ Converted $n files from png to jpg"
