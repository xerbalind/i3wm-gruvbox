#!/bin/env bash

# kill if already running
killall -9 picom dunst polybar nextcloud

# Start polybar
polybar main &

#Set random wallpaper
feh --bg-fill --randomize $HOME/wallpapers/*

#Start dunst (notification daemon)
dunst -config $HOME/.config/dunst/dunstrc &

#Set initial brightness 30% (0.3*255)
echo "76" > /sys/class/backlight/amdgpu_bl0/brightness

# Start picom
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
picom --config $HOME/.config/picom/picom.conf &

# Start nextcloud
nextcloud --background &
