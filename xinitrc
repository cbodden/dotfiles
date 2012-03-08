#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/Xresources
sysmodmap=/etc/X11/xinit/Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs


if [ -n "`/etc/X11/chooser.sh`" ]; then
	command="`/etc/X11/chooser.sh`"
else
	failsafe="yes"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/* ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi
if [ -n "$failsafe" ]; then
	/usr/bin/evilwm -snap 10 -term mrxvt &
	xsetroot -solid \#000000 -cursor_name crosshair -display :0.0
	xsetroot -solid \#000000 -cursor_name crosshair -display :0.1
	# conky --display=:0.1 &
	# trayer --expand true --transparent true  --alpha 255 --edge bottom --align right --expand true --SetDockType true --widthtype request --margin 130 --display=:0.0 &
	setxkbmap -option terminate:ctrl_alt_bksp
	xbindkeys &
        # DISPLAY=:0.0 /bin/bash scripts/work/random_images.sh &
        # DISPLAY=:0.1 /bin/bash scripts/work/random_images.sh &
	exec sleep infinity

else
	exec $command
fi
