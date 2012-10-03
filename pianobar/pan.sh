#!/bin/bash

#### pandorabar fifo control script

# lets check if fifo file exists, if not create it
PIPE=`cat /home/cbodden/.config/pianobar/config | grep -v "#" | grep fifo | tr -d "\ " | cut -d"=" -f2`
if [[ -z ${PIPE} ]]; then printf "\npianobar fifo not specified in config\nexiting\n" ; exit 1 ; fi
if [[ ! -p ${PIPE} ]]; then
    printf "\npianobar fifo does not exist\n"
    read -p "should i create it ? (y/n): " YN
    case $YN in
        [Yy]* ) mkfifo ${PIPE} ; printf -- "\npianobar fifo created\n" ;;
        [Nn]* ) exit 1 ;;
    esac
fi

# lets make sure pianobar is running, if not ask to run
if [[ ! `pgrep -u $(id -u) pianobar$` ]]; then
    printf "\npianobar is not running\n"
    read -p "should i start pianobar ? (y/n): " YN
    case $YN in
        [Yy]* ) pianobar && exit ;;
        [Nn]* ) exit 1 ;;
    esac
fi

# help stuffs
help_section() {
    printf "\n$(basename $0)\n"
    printf -- "Usage: $0 [OPTION]\n\n"
    printf -- "Options:\n"
    printf -- "+,  --love,     love        --  Love\n"
    printf -- "-,  --ban,      ban         --  Ban\n"
    printf -- "e,  --explain,  explain     --  Explain\n"
    printf -- "i,  --info,     info        --  Info\n"
    printf -- "n,  --next,     next        --  Next\n"
    printf -- "p,  --pause,    pause       --  Pause\n"
    printf -- "q,  --quit,     quit        --  Quit\n"
    printf -- "u,  --upcoming, upcoming    --  Upcoming\n"
    printf -- "vu, --volup,    volup       --  Volume Up\n"
    printf -- "vd, --voldown,  voldown     --  Volume Down\n"
    printf -- "\nvolume up and down can also have a value added:\n"
    printf -- "\n$0 [volume option] [1-25]\n\n\n"
    printf "pianobar pid (euid=$(id -u)): "
    pgrep -u $(id -u) pianobar$
    printf -- "\n"
}

# menu stuffs
case $1 in
    +|--love|love           ) printf "+" > ${PIPE} ;;
    -|--ban|ban             ) printf "-" > ${PIPE} ;;
    e|--explain|explain     ) printf "e" > ${PIPE} ;;
    i|--info|info           ) printf "i" > ${PIPE} ;;
    n|--next|next           ) printf "n" > ${PIPE} ;;
    p|--pause|pause         ) printf "p" > ${PIPE} ;;
    q|--quit|quit           ) printf "q" > ${PIPE} ;;
    u|--upcoming|upcoming   ) printf "u" > ${PIPE} ;;
    vu|--volup|volup        ) printf ")" > ${PIPE}
        count=1
        while [[ $count -lt $2 ]]; do
            printf ")" > ${PIPE}
            count=`expr $count + 1`
        done
        ;;
    vd|--voldown|voldown    ) printf "(" > ${PIPE}
        count=1
        while [[ $count -lt $2 ]]; do
            printf "(" > ${PIPE}
            count=`expr $count + 1`
        done
        ;;
    *                       ) help_section ;;
esac
