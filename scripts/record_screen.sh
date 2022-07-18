#!/bin/sh
# Record screen with ffmpeg on Linux with X11
ffmpeg -video_size 1920x1080 -framerate 25 -f x11grab -i :0.0+0,0 -f pulse -ac 2 -i default output.mkv
