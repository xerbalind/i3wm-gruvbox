#!/usr/bin/bash

num_monitors=$(xrandr | grep " connected" | wc -l)

#Go to home directory
cd $HOME

if [ $num_monitors -eq 2 ];then
	xrandr --output eDP-1 --auto --scale 0.6x0.6 --output DP-1 --auto --scale 1x1 --right-of eDP-1
	#Set correct dpi for .Xresources
	sed -E -i "s/Xft.dpi: [0-9]{3}$/Xft.dpi: 96/" .Xresources 
	#Set correct dpi for polybar
	sed -E -i "s/dpi = [0-9]{3}$/dpi = 96/" .config/polybar/config
	#Set correct height for polybar
	sed -E -i "s/height = [0-9]{2}$/height = 35/" .config/polybar/config
	#Set correct dpi for rofi in i3 config (not automatically detected)
	sed -E -i "s/-dpi [0-9]{3} /-dpi 96 /" .config/i3/config
else
	#Set correct dpi for .Xresources
	sed -E -i "s/Xft.dpi: [0-9]{2}$/Xft.dpi: 192/" .Xresources 
	#Set correct dpi for polybar
	sed -E -i "s/dpi = [0-9]{2}$/dpi = 192/" .config/polybar/config 
	#Set correct height for polybar
	sed -E -i "s/height = [0-9]{2}$/height = 65/" .config/polybar/config
	#Set correct dpi for rofi in i3 config (not automatically detected)
	sed -E -i "s/-dpi [0-9]{2} /-dpi 192 /" .config/i3/config
fi


xrdb .Xresources

exit $((num_monitors))
