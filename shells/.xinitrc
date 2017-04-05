#!/bin/bash

/usr/bin/evilwm &
xsetroot -solid \#000000 -cursor_name crosshair &
setxkbmap -option terminate:ctrl_alt_bksp &
xbindkeys &
/usr/bin/xscreensaver -no-splash &
~/Downloads/xflux -z 11221 &
~/lb/newbar.sh
exec sleep infinity
