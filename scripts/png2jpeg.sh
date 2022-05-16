#!/bin/sh
if ! command -v convert &> /dev/null
then
  echo "$(tput setaf 3)Error: Please install ImageMagick"
  exit 1
fi

convert_png2jpeg () {
  local name=$1
  local filename=$(basename -- "$name")
  local filename="${filename%.*}"
  local newname="$filename.jpeg"
  convert "$name" "$newname"
}


# no. of png files (to calculate progress correctly)
n=$(ls -l *.png *.PNG 2>/dev/null | wc -l | sed 's/ //g')
if [ $n = 0 ]; then
  echo "$(tput setaf 1)No png files found."
fi

i=0
# Redirect error to /dev/null since *.PNG files may not exist and will print a message.
ls *.png *.PNG 2>/dev/null | while read name
do
  percent=$(((i*100)/(n)))
  echo "\033[2K[$percent%] Converting $name                          \r\c"
  i=$((i+1))

  convert_png2jpeg "$name" &
done

wait
echo "$(tput setaf 2)✨ Converted $n files from png to jpeg. Please manually remove png files if you wish."
