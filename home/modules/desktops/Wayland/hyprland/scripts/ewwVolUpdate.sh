#!/usr/bin/env bash
OUTSTATE=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
INSTATE=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)

if [ "$(awk '{print $3}' <<<$OUTSTATE)" = '[MUTED]' ]; then
	eww update volOut=0 -c ~/.config/eww/
	eww update volOutState=" " -c ~/.config/eww/
else
	eww update volOut=$(awk '{print $2 * 100}' <<<$OUTSTATE) -c ~/.config/eww/
	eww update volOutState="󰕾 " -c ~/.config/eww/
fi

if [ "$(awk '{print $3}' <<<$INSTATE)" = '[MUTED]' ]; then
	eww update volIn=0 -c ~/.config/eww/
	eww update volInState="󰍮 " -c ~/.config/eww/
else
	eww update volIn=$(awk '{print $2 * 100}' <<<$INSTATE) -c ~/.config/eww/
	eww update volInState="󰍬 " -c ~/.config/eww/
fi
