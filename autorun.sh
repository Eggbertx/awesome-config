#!/usr/bin/env bash

function run {
	if ! pgrep $1 ;
	then
		$@&
	fi
}

run compton
run volumeicon
run gnome-screensaver
run xrandr --output LVDS1 --gamma 0.$level:0.$level:0.$level
# run wicd-client --tray
