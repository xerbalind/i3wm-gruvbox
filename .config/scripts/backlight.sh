#!/usr/bin/bash

# Simple script to adjust brightness. here using amdgpu_bl0 


brightness=$(cat /sys/class/backlight/amdgpu_bl0/actual_brightness)
((brightness += $1))
echo "${brightness}" > /sys/class/backlight/amdgpu_bl0/brightness
