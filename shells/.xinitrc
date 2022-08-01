#!/bin/bash

## [[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

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

## this starts xmodmap for the user
if hash xmodmap 2>/dev/null
then
    if pgrep -f xmodmap >/dev/null 2>&1
    then
        return 0
    else
        xmodmap ~/.Xmodmap \
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

## this runs redshift in the background
#if hash redshift 2>/dev/null
#then
#    if pgrep -f redshift >/dev/null 2>&1
#    then
#        return 0
#    else
#        redshift \
#            -l geoclue2 \
#            -t 6500:3000 \
#            &
#    fi
#fi

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

## this starts the X compositing manager (shnazzy)
#if hash xcompmgr 2>/dev/null
#then
#    if pgrep -f xcompmgr >/dev/null 2>&1
#    then
#        return 0
#    else
#        xcompmgr \
#            -c \
#            -f \
#            &
#    fi
#fi

## this is to fix the ewmh issues on the dell
if hash picom 2>/dev/null
then
    if pgrep -f picom >/dev/null 2>&1
    then
        return 0
    else
        picom \
            --use-ewmh-active-win \
            --backend glx \
            --mark-wmwin-focused \
            --corner-radius 7 \
            --daemon \
            &
    fi
fi

## polybar
if hash polybar 2>/dev/null
then
    if pgrep -f polybar >/dev/null 2>&1
    then
        return 0
    else
        /home/cbodden/git/mine/dotfiles/polybar/polybar.sh \
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
        xbacklight -dec 60 &
        ## this blocks exiting unless forcefully exited
        exec sleep infinity
    fi
else
    exit 1
fi

#### errata
