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
    if [[ -f $(which figlet 2>/dev/null) ]]; then
        printf "%s" "${GRN}"
        command figlet -c $(hostname)
    fi
}

function last() {
    if [[ $(lastlog -u $USER \
        | awk 'END {print $2}') = tty* ]]; then
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
        | awk '{printf "LOAD1=%s; LOAD5=%s; LOAD15=%s;", \
        $1,$2,$3};' -)
    printf "%s%s%s%s\n" "${MGN}" "Load.......: " "${BLU}" \
        "${LOAD1} (1 minute) ${LOAD5} (5 minutes) ${LOAD15} (15 minutes)"
}

function memory() {
    eval $(free -m \
        | awk '/^Mem:/ {printf "MEM=%s; USED=%s; FREE=%s; \
        FREE_CACHE=%s;", $2,$3,$4,$6};')
    eval $(free -m \
        | awk '/^Swap:/ {printf "SWAP_USE=%s;", $3};')
    printf "%s%s%s%s%s\n" "${MGN}" "Memory MB..: " "${BLU}" \
        "${MEM}mb, Used: ${USED}mb, Free: ${FREE}mb, " \
        "Free Cached: ${FREE_CACHE}mb, Swap In Use: ${SWAP_USE}mb"
}

function diskusage() {
    local DUH=$(du -ms $(echo $HOME) \
        | awk '{ print $1 }')
    printf "%s%s%s%s\n" "${MGN}" "Disk Usage.: " "${BLU}" \
        "You are using ${DUH}mb in ${HOME}"
}

function ssh() {
    local USERS=$(who \
        | awk '{print $1}' \
        | sort \
        | uniq \
        | wc -l)
    printf "%s%s%s%s\n" "${MGN}" "SSH Logins.: " "${BLU}" \
        "There are currently ${USERS} users logged in"
}

function proc() {
    local P_TOT=$(ps -A h \
        | wc -l)
    local P_USR=$(ps U ${USER} \
        | wc -l)
    printf "%s%s%s%s\n" "${MGN}" "Processes..: " "${BLU}" \
        "${P_TOT} total running of which ${P_USR} are yours"
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
    if [[ -f $(which fortune 2>/dev/null) ]]; then
        if [[ -f $(which cowthink 2>/dev/null) ]]; then
            printf "%s\n" "${RED}"
            command fortune \
                | cowthink -f $(ls /usr/share/cowsay-3.03/cows \
                | shuf -n1)
        fi
    fi
}

## functions below
main
figlet
last
uptime
load
memory
diskusage
ssh
proc
rules
fortune
