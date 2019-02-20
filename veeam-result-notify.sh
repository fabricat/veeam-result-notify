#!/bin/bash
JOB_NAME="BackupJob1"

if [ -n "$1" ]; then
	JOB_NAME="$1"
fi

# Inspired by https://forums.linuxmint.com/viewtopic.php?t=279095
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
	if [ -S /run/user/$EUID/bus ]; then
		export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$EUID/bus"
	else
		SESSION=$(loginctl -p Display show-user "$LOGNAME" | cut -d= -f2)
		LEADER=$(loginctl -p Leader show-session "$SESSION" | cut -d= -f2)
		OLDEST=$(pgrep -o -P $LEADER)
		export $(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$OLDEST/environ)
	fi
fi


if ! (id -nG | grep -qw veeam); then
	notify-send -i dialog-warning "$0" 'This script must be run by a user in the "veeam" group!'
	exit 3
fi


SESSION_ID="$(veeamconfig session list | grep "^${JOB_NAME} " | tail -1 | awk '{print $3}')"
SESSION_INFO="$(veeamconfig session info --id ${SESSION_ID} | tail -6)"
SESSION_STATE="$(echo "$SESSION_INFO" | grep 'State: ' | awk '{print $2}')"
NOTIF_TITLE="Veeam last backup result: $SESSION_STATE"

if [ "$SESSION_STATE" == "Success" ]
then
	notify-send "$NOTIF_TITLE" "$SESSION_INFO"
else
	notify-send -u critical "$NOTIF_TITLE" "$SESSION_INFO\n\n$(veeamconfig session log --id ${SESSION_ID} | grep -v '\[processing\]' | cut -d' ' -f5-)"
fi
