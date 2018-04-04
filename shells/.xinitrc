#!/bin/bash

/usr/bin/evilwm &
/usr/bin/xset fp+ /usr/share/fonts/terminus
/usr/bin/xset fp+ /usr/share/fonts/proggy-fonts
xsetroot -solid \#000000 -cursor_name crosshair &
setxkbmap -option terminate:ctrl_alt_bksp &
xbindkeys &
/usr/bin/xscreensaver -no-splash &
~/Downloads/xflux -z 11221 &
xset m 1 1
exec sleep infinity
