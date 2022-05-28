#!/bin/sh
programa=$(pgrep wf-recorder)

if [ -n "$programa" ]; then
	killall -s SIGINT wf-recorder
	notify-send "Grabación finalizada"
	exit 0
else
	wf-recorder -o eDP-1 -f ~/Videos/"grabacion-$(date +"%s-%d-%m-%Y").mp4"
	exit 1
fi

