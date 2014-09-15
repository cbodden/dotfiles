#!/bin/bash

# /usr/bin/evilwm -snap 10 -term mrxvt -nosoliddrag -fg purple -bg black -bw 1 &
/usr/bin/evilwm -snap 10 -term urxvt -nosoliddrag -fg purple -bg black -bw 1 &
xsetroot -solid \#000000 -cursor_name crosshair
setxkbmap -option terminate:ctrl_alt_bksp
xbindkeys &
/usr/bin/xscreensaver -no-splash &
#DISPLAY=:0.0 /bin/bash /home/cbodden/startup/random_images.sh &
/usr/bin/xv -quit -root -rmode 5 /home/cbodden/wallpapers/tsoi.gif
exec sleep infinity
