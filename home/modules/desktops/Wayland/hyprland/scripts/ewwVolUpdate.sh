#!/usr/bin/env bash
OUTSTATE=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
INSTATE=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)

if [ "$(awk '{print $3}' <<<$OUTSTATE)" = '[MUTED]' ]; then
	eww update volOut=0
	eww update volOutState=" "
else
	eww update volOut=$(awk '{print $2 * 100}' <<<$OUTSTATE)
	eww update volOutState="󰕾 "
fi

if [ "$(awk '{print $3}' <<<$INSTATE)" = '[MUTED]' ]; then
	eww update volIn=0
	eww update volInState="󰍮 "
else
	eww update volIn=$(awk '{print $2 * 100}' <<<$INSTATE)
	eww update volInState="󰍬 "
fi
