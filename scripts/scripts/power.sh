#!/bin/sh

STATE=""
BAT="BAT0"

if [[ "$1" == "BAT" || "$1" == "AC" ]]; then
	STATE="$1"
fi


if [[ $STATE == "" ]]; then
	if [[ $(grep -i discharging /sys/class/power_supply/"$BAT"/status) == "" ]]; then
		STATE="AC"
	else 
		STATE="BAT"
	fi
fi

echo $STATE

if [[ $STATE == "BAT" ]]; then
	echo "Discharging. Set governor to conservative."
	cpupower frequency-set -g conservative
elif [[ $STATE == "AC" ]]; then
	echo "Charging. Set governor to ondemand."
	cpupower frequency-set -g ondemand 
fi
