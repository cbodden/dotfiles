#!/bin/bash

# /usr/bin/evilwm -snap 10 -term mrxvt -nosoliddrag -fg purple -bg black -bw 1 &
/usr/bin/evilwm -snap 10 -term urxvt -nosoliddrag -fg purple -bg black -bw 1 &
xsetroot -solid \#000000 -cursor_name crosshair
trayer --SetPartialStrut true --expand true --transparent true --alpha 255 --edge bottom --align right --expand true --SetDockType true --widthtype request --heighttype request --margin 1 --padding 1 &
setxkbmap -option terminate:ctrl_alt_bksp
xbindkeys &
/usr/bin/xscreensaver -no-splash &
nm-applet &x
#DISPLAY=:0.0 /bin/bash /home/cbodden/startup/random_images.sh &
#xcompmgr -cCfF -t-5 -l-5 -r4.2 -o.55 -D6 -d :0.0
exec sleep infinity
