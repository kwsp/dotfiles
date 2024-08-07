#!/bin/sh
if ! command -v convert &> /dev/null
then
  echo "$(tput setaf 3)Error: Please install ImageMagick"
  exit 1
fi

i=0
# no. of png files (to calculate progress correctly)
n=$(ls -l *.png *.PNG 2>/dev/null | wc -l | sed 's/ //g')
# Redirect error to /dev/null since *.PNG files may not exist and will print a message.
ls *.png *.PNG 2>/dev/null | while read name
do
  percent=$(((i*100)/(n)))
  filename=$(basename -- "$name")
  filename="${filename%.*}"
  newname="$filename.jpg"
  echo "[$percent%] Converting $name                          \r\c"
  convert "$name" "$newname"
  i=$((i+1))
done

echo "$(tput setaf 2)✨ Converted $n files from png to jpg. Please manually remove png files if you wish."
