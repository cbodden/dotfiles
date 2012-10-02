#!/bin/bash

# copied from https://github.com/evaryont/dotfiles/blob/master/config/pianobar/eventcmd.sh
# added tmux integration

# create variables
while read L; do
    k="`echo "$L" | cut -d '=' -f 1`"
    v="`echo "$L" | cut -d '=' -f 2`"
    export "$k=$v"
done < <(grep -e '^\(artist\|title\|album\|coverArt\|stationName\|songStationName\|pRet\|pRetStr\|wRet\|wRetStr\|songDuration\|songPlayed\|rating\|detailUrl\|stationCount\|station[0-9]*\)=' /dev/stdin) # don't overwrite $1..

# artist - Current song's artist
# title - Current song's title
# album - Current song's album
# coverArt - The album cover, URL to JPG
# rating - 0 for no rating, 1 for a loved song, 2 for a banned one.
# detailUrl - Link to the individual song's page on Pandora
# pRet - 1 on OK, otherwise specific error Pandora error
# pRetStr - A human-readable description of the error message
# wRet - 1 on OK, otherwise a network error
# wRetStr - A human-readable description of the network error
# songDuration - How long the song is, in seconds
# songPlayed - How many seconds of the song have played
# stationName - the name of the current station
# songStationName - the name of the station the song belongs to (QuickMix)
# stationCount - How many stations the user has. NB: Can be 0!
# station0..stationN (N == stationCount) - Each of the user's stations, by name

case "$1" in
    songstart)
        if [[ -n "$DISPLAY" ]]; then
            notify-send "Pandora Radio" "Now playing: $title by $artist"
        fi

        if [[ $USER == root || `ps -ef | egrep tmux | egrep -v egrep | wc -l` -gt 0 ]]; then
            tmux rename-session " $title by $artist "
        fi

        echo "$stationName : $title by $artist " >> /tmp/pianobar_played
        echo "$title by $artist" > $HOME/.config/pianobar/now_playing
    ;;

    *)
        if [[ -n "$DISPLAY" ]]; then
            if [[ "$pRet" -ne 1 ]]; then
                notify-send "Pandora Radio" "$1 failed: $pRetStr"
            elif [[ "$wRet" -ne 1 ]]; then
                notify-send "Pandora Radio" "$1 failed: Network error: $wRetStr"
            fi
        fi
    ;;
esac
