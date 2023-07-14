#!/bin/bash
operation=$1

if [[ "$operation" == 'lock' ]]; then
	termux-wake-lock
	sshd
else
	termux-wake-unlock
fi
