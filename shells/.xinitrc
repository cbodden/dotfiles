#!/bin/bash

## this sets the root bg color, window bg color, and cursor
if hash xsetroot 2>/dev/null
then
    xsetroot \
        -background "#000000"  \
        -cursor_name crosshair \
        -solid "#000000" \
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
        --fork \
        --jitter 300 \
        --timeout 10 \
        &
fi

## daemonize urxvt to save memory running urxvtc
if hash urxvtd 2>/dev/null
then
    urxvtd \
        --fork \
        --opendisplay \
        --quiet \
        &
fi

## this starts the wm
if hash xmonad 2>/dev/null
then
    # evilwm -term urxvt &
    xmonad \
        &
    ## this blocks exiting unless forcefully exited
    exec sleep infinity
else
    exit 1
fi

#### errata
# xcompmgr -c -f &
