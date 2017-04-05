#!/usr/bin/env bash

readonly BG="#000000"
readonly FG="#657b83"
readonly BLK="#707070"
readonly DRK="#000000"

desk(){
    local _CUR=$(\
        xprop -root _NET_CURRENT_DESKTOP \
        | awk '{print $3}')
    case $_CUR in
        0)
            echo "\
                %{F$FG}[1]${F-}%{B$DRK} 2 ${F-}%{B$DRK} 3 \
                ${F-}%{B$DRK} 4 ${F-}%{B$DRK} 5 ${F-}%{B$DRK} 6 \
                ${F-}%{B$DRK} 7 ${F-}%{B$DRK} 8 "
            ;;
        1)
            echo "\
                ${F-}%{B$DRK} 1 %{F$FG}[2]${F-}%{B$DRK} 3 \
                ${F-}%{B$DRK} 4 ${F-}%{B$DRK} 5 ${F-}%{B$DRK} 6 \
                ${F-}%{B$DRK} 7 ${F-}%{B$DRK} 8 "
            ;;
        2)
            echo "\
                ${F-}%{B$DRK} 1 ${F-}%{B$DRK} 2 %{F$FG}[3]${F-}%{B$DRK} 4 \
                ${F-}%{B$DRK} 5 ${F-}%{B$DRK} 6 \
                ${F-}%{B$DRK} 7 ${F-}%{B$DRK} 8 "
            ;;
        3)
            echo "\
                ${F-}%{B$DRK} 1 ${F-}%{B$DRK} 2 ${F-}%{B$DRK} 3 \
                %{F$FG}[4]${F-}%{B$DRK} 5 ${F-}%{B$DRK} 6 \
                ${F-}%{B$DRK} 7 ${F-}%{B$DRK} 8 "
            ;;
        4)
            echo "\
                ${F-}%{B$DRK} 1 ${F-}%{B$DRK} 2 ${F-}%{B$DRK} 3 \
                ${F-}%{B$DRK} 4 %{F$FG}[5]${F-}%{B$DRK} 6 \
                ${F-}%{B$DRK} 7 ${F-}%{B$DRK} 8 "
            ;;

        5)
            echo "\
                ${F-}%{B$DRK} 1 ${F-}%{B$DRK} 2 ${F-}%{B$DRK} 3 \
                ${F-}%{B$DRK} 4 ${F-}%{B$DRK} 5 %{F$FG}[6]${F-}%{B$DRK} 7 \
                ${F-}%{B$DRK} 8 "
            ;;
        6)
            echo "\
                ${F-}%{B$DRK} 1 ${F-}%{B$DRK} 2 ${F-}%{B$DRK} 3 \
                ${F-}%{B$DRK} 4 ${F-}%{B$DRK} 5 ${F-}%{B$DRK} 6 \
                %{F$FG}[7]${F-}%{B$DRK} 8 "
            ;;
        7)
            echo "\
                ${F-}%{B$DRK} 1 ${F-}%{B$DRK} 2 ${F-}%{B$DRK} 3 \
                ${F-}%{B$DRK} 4 ${F-}%{B$DRK} 5 ${F-}%{B$DRK} 6 \
                ${F-}%{B$DRK} 7 %{F$FG}[8]${F-}%{B$DRK}"
            ;;
        *)
            echo "*"
    esac
}

temperature(){
    local _TEMPC=$(\
        sensors \
        | grep "Package id 0" \
        | cut -d'+' -f2 \
        | awk '{print $1}')
    local _TEMPF=$(\
        sensors -f \
        | grep "Package id 0" \
        | cut -d'+' -f2 \
        | awk '{print $1}')
    echo %{F$FG}[ $_TEMPC / $_TEMPF ]%{F-}
}

life(){
    local _BAT=$(\
        cat /sys/class/power_supply/BAT0/capacity)
    echo %{F$FG}[ $_BAT% ]%{F-}
}

clock() {
    local _TIME=$(\
        date "+%d-%b-%y %H:%M")
    echo %{F$FG}[ $_TIME ]%{F-}
}

statusbar(){
    echo "$(clock) %{c} $(desk) %{r} $(temperature)$(life)"
}

while :
do
    echo $(statusbar)
    sleep 0.2
done \
    | lemonbar -B ${BG} -F ${FG} -b -d &
