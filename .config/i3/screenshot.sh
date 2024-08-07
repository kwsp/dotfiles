#!/bin/bash
# Take a screenshot with ffmpeg
ffmpeg -f x11grab -video_size 1920x1080 -i $DISPLAY -vframes 1 ~/Pictures/$(date -Iseconds).png
