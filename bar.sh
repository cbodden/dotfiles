#!/usr/bin/env bash

readonly BG="#002b36"
readonly FG="#657b83"
readonly BLK="#707070"
readonly RES="1366x15x0x0"
readonly WMN="bar"
readonly BRKT="#268bd2"
readonly VDS="#dc322f"

desk(){
    local _CUR=$(\
        xprop -root _NET_CURRENT_DESKTOP \
        | awk '{print $3}')
    case $_CUR in
        0)
            echo "\
                %{F$BRKT}[%{F$VDS}1%{F$BRKT}]%{F$FG} 2 ${F-} 3 \
                ${F-} 4 ${F-} 5 ${F-} 6 ${F-} 7 ${F-} 8 "
            ;;
        1)
            echo "\
                %{F$FG} 1 %{F$BRKT}[%{F$VDS}2%{F$BRKT}]%{F$FG} 3 \
                ${F-} 4 ${F-} 5 ${F-} 6 ${F-} 7 ${F-} 8 "
            ;;
        2)
            echo "\
                %{F$FG} 1 ${F-} 2 %{F$BRKT}[%{F$VDS}3%{F$BRKT}]%{F$FG} 4 \
                ${F-} 5 ${F-} 6 ${F-} 7 ${F-} 8 "
            ;;
        3)
            echo "\
                %{F$FG} 1 ${F-} 2 ${F-} 3 \
                %{F$BRKT}[%{F$VDS}4%{F$BRKT}]%{F$FG} 5 ${F-} 6 ${F-} 7 ${F-} 8 "
            ;;
        4)
            echo "\
                %{F$FG} 1 ${F-} 2 ${F-} 3 \
                ${F-} 4 %{F$BRKT}[%{F$VDS}5%{F$BRKT}]%{F$FG} 6 ${F-} 7 ${F-} 8 "
            ;;
        5)
            echo "\
                %{F$FG} 1 ${F-} 2 ${F-} 3 ${F-} 4 ${F-} 5 \
                %{F$BRKT}[%{F$VDS}6%{F$BRKT}]%{F$FG} 7 ${F-} 8 "
            ;;
        6)
            echo "\
                %{F$FG} 1 ${F-} 2 ${F-} 3 ${F-} 4 ${F-} 5 ${F-} 6 \
                %{F$BRKT}[%{F$VDS}7%{F$BRKT}]%{F$FG} 8 "
            ;;
        7)
            echo "\
                %{F$FG} 1 ${F-} 2 ${F-} 3 ${F-} 4 ${F-} 5 ${F-} 6 \
                ${F-} 7 %{F$BRKT}[%{F$VDS}8%{F$BRKT}]${F-}"
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

load(){
    local CNT=0
    local _TP=$(grep processor /proc/cpuinfo \
        | wc -l)

    local _1MIN=$(uptime \
        | grep -ohe 'load average[s:][: ].*' \
        | awk '{ print $3 }' \
        | sed 's/,//')

    local _5MIN=$(uptime \
        | grep -ohe 'load average[s:][: ].*' \
        | awk '{ print $4 }' \
        | sed 's/,//')

    local _15MIN=$(uptime \
        | grep -ohe 'load average[s:][: ].*' \
        | awk '{ print $5 }')

    _LDS=("${_1MIN}" "${_5MIN}" "${_15MIN}")

    for _CL in "${_LDS[@]}"
    do
        if [ "${_CL%%.*}" -ge "$((_TP * 50 / 100))" ] && [ "${_CL%%.*}" -lt "$((_TP * 75 / 100))" ]
        then
            export _L${CNT}="#ffff00"
        elif [ "${_CL%%.*}" -ge "$((_TP * 75 / 100))" ]
        then
            export _L${CNT}="#ff0000"
        else
            export _L${CNT}="#657b83"
        fi
        local CNT=$((CNT+1))
    done
    echo %{F$FG}[ %{F$_L0}${_LDS[0]} %{F$_L1}${_LDS[1]} %{F$_L2}${_LDS[2]}%{F-} ]
}

clock() {
    local _TIME=$(\
        date "+%d-%b-%y %H:%M")
    echo %{F$FG}[ $_TIME ]%{F-}
}

statusbar(){
    echo "$(clock)$(life) %{c} $(desk) %{r} $(load)$(temperature)"
}

while :
do
    echo $(statusbar)
    sleep 0.2
done \
    | lemonbar -B ${BG} -F ${FG} -g ${RES} -n ${WMN} &
