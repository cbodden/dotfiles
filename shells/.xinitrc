#!/bin/bash

/usr/bin/evilwm -snap 10 -term urxvt -nosoliddrag -fg purple -bg black -bw 1 &
xsetroot -solid \#000000 -cursor_name crosshair &
setxkbmap -option terminate:ctrl_alt_bksp &
xbindkeys &
/usr/bin/xscreensaver -no-splash &
~/Downloads/xflux -z 11221 &
exec sleep infinity
