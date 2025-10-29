#!/bin/bash
# Using: https://superuser.com/a/776168
echo "Tip: use with \` | sort -V\`"
for file in *.mkv */*.mkv
#for file in *.mkv
  do
  # https://superuser.com/a/776168
  ffprobe -i "$file" -show_entries format=duration -v quiet -of csv="p=0" | awk '{printf "\033[1m" $1/60 " min\033[0m "}'
  echo "$file"
done


