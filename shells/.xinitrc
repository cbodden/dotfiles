#!/bin/bash

## this sets alt + ctrl + del to breakout of wm
if hash setxkbmap 2>/dev/null
then
    if pgrep -f setxkbmap >/dev/null 2>&1
    then
        return 0
    else
        setxkbmap \
            -option terminate:ctrl_alt_bksp \
            &
    fi
fi

## this starts the xscreensaver daemon
if hash xscreensaver 2>/dev/null
then
    if pgrep -f xscreensaver >/dev/null 2>&1
    then
        return 0
    else
        xscreensaver \
            -no-splash \
            &
    fi
fi

## this runs xflux in the background
if hash xflux 2>/dev/null
then
    if pgrep -f xflux >/dev/null 2>&1
    then
        return 0
    else
        xflux \
            -z 10010 \
            &
    fi
fi

## this hides the cursor after 10 seconds and waits for at least 300px movement
if hash unclutter 2>/dev/null
then
    if pgrep -f unclutter >/dev/null 2>&1
    then
        return 0
    else
        unclutter \
            --fork \
            --jitter 150 \
            --timeout 10 \
            &
    fi
fi

## this starts the wm
if hash xmonad 2>/dev/null
then
    if pgrep -f xmonad >/dev/null 2>&1
    then
        return 0
    else
        # evilwm -term urxvt &
        xmonad \
            &
        ## this blocks exiting unless forcefully exited
        exec sleep infinity
    fi
else
    exit 1
fi

#### errata
# xcompmgr -c -f &
