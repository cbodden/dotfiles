#!/usr/bin/env bash

function main()
{
    # text format && color
    ORN=$(tput setaf 3)
    RED=$(tput setaf 1)
    BLU=$(tput setaf 4)
    GRN=$(tput setaf 40)
    MGN=$(tput setaf 5)
    CLR=$(tput sgr0)
}

function figlet() {
    if [[ -f $(which figlet 2>/dev/null) ]]
    then
        printf "%s" "${GRN}"
        command figlet \
            -f "$(shuf -n 1 -e ~/git/mine/dotfiles/figlet-fonts/*)" \
            -l \
            -w $(tput cols) \
            $(hostname)
    fi
}

function last() {
    if [[ $(lastlog -u $USER \
        | awk 'END {print $2}') = tty* ]]
    then
        local LL=$(lastlog -u $USER \
            | tail -n 1)
        local FROM=$(echo ${LL} \
            | awk '{ print $2 }')
        local AT=$(echo ${LL} \
            | awk '{ print $3,$4,$5,$6 }')
    else
        local LL=$(lastlog -u $USER \
            | tail -n 1)
        local FROM=$(echo ${LL} \
            | awk '{ print $3 }')
        local AT=$(echo ${LL} \
            | awk '{ print $4,$5,$6,$7 }')
    fi
    printf "\n%s%s%s%s\n" "${MGN}" "Last Login.: " "${BLU}" \
        "From ${FROM} on ${AT}"
}

function uptime() {
    local UPTOT=$(cut -d. -f1 /proc/uptime)
    local UPD=$(expr ${UPTOT} / 60 / 60 / 24)
    local UPH=$(expr ${UPTOT} / 60 / 60 % 24)
    local UPM=$(expr ${UPTOT} / 60 % 60)
    local UPS=$(expr ${UPTOT} % 60)
    printf "%s%s%s%s\n" "${MGN}" "Uptime.....: " "${BLU}" \
        "${UPD} days ${UPH} hours ${UPM} minutes ${UPS} seconds"
}

function load() {
    eval $(cat /proc/loadavg \
        | awk '{printf "LOAD1=%s; LOAD5=%s; LOAD15=%s;", $1,$2,$3};' -)
    printf "%s%s%s%s\n" "${MGN}" "Load.......: " "${BLU}" \
        "${LOAD1} (1 minute) ${LOAD5} (5 minutes) ${LOAD15} (15 minutes)"
}

function memory() {
    eval $(free --giga \
        | awk '/^Mem:/ {printf "MEM=%s; USED=%s; FREE=%s; \
        FREE_CACHE=%s;", $2,$3,$4,$6};')
    eval $(free --giga \
        | awk '/^Swap:/ {printf "SWAP_USE=%s;", $3};')
    printf "%s%s%s%s%s\n" "${MGN}" "Memory GB..: " "${BLU}" \
        "${MEM}GB, Used: ${USED}GB, Free: ${FREE}GB, " \
        "Free Cached: ${FREE_CACHE}GB, Swap In Use: ${SWAP_USE}GB"
}

function diskusage() {
    local DUH=$(du -hs $(echo $HOME) \
        | awk '{ print $1 }')
    printf "%s%s%s%s\n" "${MGN}" "Disk Usage.: " "${BLU}" \
        "You are using ${DUH} in ${HOME}"
}

function ssh() {
    local USERS=$(who \
        | awk '{print $1}' \
        | sort \
        | uniq \
        | wc -l)
    if [ ${USERS} -le 1 ]
    then
        local _AMT_A="is"
        local _AMT_B="user"
    else
        local _AMT_A="are"
        local _AMT_B="users"
    fi
    printf "%s%s%s%s\n" "${MGN}" "SSH Logins.: " "${BLU}" \
        "There ${_AMT_A} currently ${USERS} ${_AMT_B} logged in"
}

function proc() {
    local P_TOT=$(ps -A h \
        | wc -l)
    local P_USR=$(ps U ${USER} \
        | wc -l)
    printf "%s%s%s%s\n" "${MGN}" "Processes..: " "${BLU}" \
        "${P_TOT} total running of which ${P_USR} are yours"
}

function temperature() {
    curl -s ipinfo.io > /tmp/motd.out

    local _INFO="city region postal"

    for ITER in ${_INFO}
    do
        local ${ITER^^}="$(cat /tmp/motd.out \
            | sed -n -e 's/^.*'"${ITER,,}"'": //p' \
            | tr -d '[",]')"
    done

    eval ACCU="http://rss.accuweather.com/rss/liveweather_rss.asp"
    eval MET="\?metric\=\"2\""
    eval L_CODE="\&locCode\=\"${POSTAL}\""

    if [[ -n ${REGION} ]]
    then
        local DEGTMP=$(curl -s ${ACCU}${MET}${L_CODE} \
            | sed -n \
                '/Currently:/ s/.*: \(.*\): \([0-9]*\)\([CF]\).*/\2°\3, \1/p' \
            | tr -d '[",]')
        printf "%s%s%s%s\n" "${MGN}" "Temperature: " "${BLU}" \
            "${CITY}, ${REGION}: ${DEGTMP}"
    fi
}

function rules() {
    printf "%s" "${GRN}"
local R_TXT="
H4sIAFVjdVcAA4WOQW7CMBBF9znFPwDJASplQdWURgQS2aESy2kYkhGJHdmGyrcvge75mtX80ZuX
AG8vk6pDVej09WGCJe0gHvchzE5uFBg++sATwkAB0V5BjmFsQLDo5caw1wDqOvZ+WZGJ1vCT9Sth
WNqZ3STeizU4O7ugGHSaxGTYW8g4ck8jzjKyh3V3WJCbhJhBB4qrB0vM8tthsBPjJI67YF1c4cI8
P3j/lt3IZFZ3ixMmujAc99eRHH6ouxwanT3F0jwHPkq9fq8KHOuDQqPqjVrvND5VvcO2KJpyv4Eu
9rpsy+8CVb3RqBW+St3W6og8T5PkD18OD5WAAQAA"
    echo "${R_TXT}" | base64 -d | gunzip
}

function fortune() {
    if [[ -f $(which fortune 2>/dev/null) ]]
    then
        if [[ -f $(which cowthink 2>/dev/null) ]]
        then
            printf "%s\n" "${RED}"
            command fortune \
                | cowthink \
                -f "$(\
                ls --ignore=\*.pm /usr/share/cowsay/cows \
                | rev \
                | cut -d"." -f2-4 \
                | rev \
                | shuf -n1)"
        fi
    fi
}

## functions below
main
# perl ~/git/mine/dotfiles/256colors.pl
figlet
last
uptime
load
memory
diskusage
ssh
proc
temperature
rules
fortune
