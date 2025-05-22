## base taken from:
## reddit.com/r/suckless/comments/l7la29/making_a_posix_dwm_status_script_with_signalling/

#!/bin/sh
exec 2>&1
printf "$$" > ~/.cache/pidofbar
sec=0

update_cpu () {
    cpu="$( grep -o "^[^ ]*" /proc/loadavg )"
}

update_memory () {
    memory="$( free -h \
        | sed -n "2s/\([^ ]* *\)\{2\}\([^ ]*\).*/\2/p" \
        )"
}

update_time () {
    time="$( date "+%a %d-%b-%y · %R" )"
}

update_bat () {
    read -r bat_status </sys/class/power_supply/BAT0/status
    read -r bat_capacity </sys/class/power_supply/BAT0/capacity
    [[ ${bat_capacity} -gt 95 ]] \
        && bat_icon="󰁹" \
        || bat_icon="󰁼"
    ##bat="$bat_status $bat_icon $bat_capacity"
    bat="$bat_icon $bat_capacity"
}

update_vol () {
    vol="$([ "$(pulsemixer --get-mute)" = "0" ] \
        && printf '🔊 ' || printf '🔇 ')$(pulsemixer --get-volume \
        | awk '{print $1}')%"
}

display () {
    ##printf "%s\n" \
    ##    "· ${memory} ${cpu} · ${bat} · ${vol} · ${time} ·"

    ##xsetroot -name "[${memory} ${cpu}] [${bat}] [${vol}] ${time} "
    xsetroot -name "· ${memory} ${cpu} · ${bat} · ${vol} · ${time} ·"
}

# signals for each module to update while updating display. RTMIN is 34
trap "update_vol;display" "RTMIN"
trap "update_bat;display" "RTMIN+2"

while true
do
    # how many seconds each module updates
    [ $((sec % 5 )) -eq 0 ] && update_vol
    [ $((sec % 5 )) -eq 0 ] && update_time
    [ $((sec % 15)) -eq 0 ] && update_cpu
    [ $((sec % 15)) -eq 0 ] && update_memory
    [ $((sec % 15 )) -eq 0 ] && update_bat

    # how often the display updates
    [ $((sec % 5 )) -eq 0 ] && display

    sleep 1 & wait && sec=$((sec + 1))
done
