#!/bin/bash

## this sets the root bg color, window bg color, and cursor
if hash xsetroot 2>/dev/null
then
    xsetroot \
        -solid "#000000" \
        -background "#000000"  \
        -cursor_name crosshair \
        &
fi

## this sets alt + ctrl + del to breakout of wm
if hash setxkbmap 2>/dev/null
then
    setxkbmap \
        -option terminate:ctrl_alt_bksp \
        &
fi

## this sets xbindkeys
if hash xbindkeys 2>/dev/null
then
    xbindkeys \
        &
fi

## this starts the xscreensaver daemon
if hash xscreensaver 2>/dev/null
then
    xscreensaver \
        -no-splash \
        &
fi

## this runs xflux in the background
if hash xflux 2>/dev/null
then
    xflux \
        -z 10010 \
        &
fi

## this merges the xresources / xdefaults file for font compatability
if hash xrdb 2>/dev/null
then
    xrdb \
        -merge ~/.Xresources \
        &
fi

## this hides the cursor after 10 seconds and waits for at least 300px movement
if hash unclutter 2>/dev/null
then
    unclutter \
        --timeout 10 \
        --jitter 300 \
        --fork \
        &
fi

## this starts xmonad
if hash xmonad 2>/dev/null
then
    xmonad \
        &
fi

## this blocks exiting unless forcefully exited
exec sleep infinity


#### errata
# urxvtd -q -f -o &
# xcompmgr -c -f &
# evilwm -term urxvt &
