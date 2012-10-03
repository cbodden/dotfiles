#!/bin/bash

#### pandorabar fifo control script

# lets check if fifo file exists
PIPE=`cat /home/cbodden/.config/pianobar/config | grep fifo | tr -d "\ " | cut -d"=" -f2`
if [[ ! -p ${PIPE} ]]; then
    printf "\npianobar fifo does not exist\nexiting\n"
    exit 1
fi

# lets make sure pianobar is running
if [[ ! `pgrep -u $(id -u) pianobar$` ]]; then
    printf "\npianobar is not running\nexiting\n"
    exit 1
fi

# help stuffs
help_section() {
    printf "$(basename $0)\n"
    printf "Usage: $0 [OPTION]\n\n"
    printf "Options:\n"
    printf "+,  --love,     love        --  Love\n"
    printf "\-, --ban,      ban         --  Ban\n"
    printf "e,  --explain,  explain     --  Explain\n"
    printf "i,  --info,     info        --  Info\n"
    printf "n,  --next,     next        --  Next\n"
    printf "p,  --pause,    pause       --  Pause\n"
    printf "q,  --quit,     quit        --  Quit\n"
    printf "u,  --upcoming, upcoming    --  Upcoming\n"
    printf "vu, --volup,    volup       --  Volume Up\n"
    printf "vd, --voldown,  voldown     --  Volume Down\n\n"
    printf "pianobar pid (euid=$(id -u)): "
    pgrep -u $(id -u) pianobar$
}

# lets begin menu stuffs
case $1 in
    +|--love|love           ) printf "+" > ${PIPE} ;;
    -|--ban|ban             ) printf "-" > ${PIPE} ;;
    e|--explain|explain     ) printf "e" > ${PIPE} ;;
    i|--info|info           ) printf "i" > ${PIPE} ;;
    n|--next|next           ) printf "n" > ${PIPE} ;;
    p|--pause|pause         ) printf "p" > ${PIPE} ;;
    q|--quit|quit           ) printf "q" > ${PIPE} ;;
    u|--upcoming|upcoming   ) printf "u" > ${PIPE} ;;
    vu|--volup|volup        ) printf ")" > ${PIPE} ;;
    vd|--voldown|voldown    ) printf "(" > ${PIPE} ;;
    *                       ) help_section ;;
esac
