#!/bin/bash

xset +fp /home/tiger/.local/share/fonts
xset fp rehash
#transmission-daemon &
#xsetroot -cursor_name left_ptr &
xinput set-prop 11 282 1 # Natural scrolling
xinput set-prop 11 298 1 # Tapping enabled
xinput set-prop 11 306 0 # disable "disbale while typing"
#exec sxhkd &
#picom --experimental-backends --backend glx -b &
#dunst &
#dock.sh &
#auto-connect-bt.sh &
#remaps &
#timer-checkupdates.sh &
#newsboat -x reload &
#SPTN.sh &
#MO.sh &
exec i3
