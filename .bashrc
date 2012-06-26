# /etc/skel/.bashrc
#
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

##### exports ####
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=screen-256color
#### end exports ####

#### bash_history timestamps and size ####
HISTTIMEFORMAT='%F %T '
export HISTTIMEFORMAT
export HISTSIZE=9999
export HISTFILESIZE=999999
#### end bash_history timestamp ####

#### mutt aliase ####
alias mail='tmux rename-window "emails" && mutt'
#### end mutt aliase ####

#### aliases ####
alias dud100='du -a --max-depth=1 | sort -n | awk '\''{if($1 > 102400) print $1/1024 "MB" " " $2 }'\'''
alias dud='du --max-depth=1 -h'
alias duf='du -sk * | sort -n | while read size fname; do for unit in k M G T P E Z Y; do if [ $size -lt 1024 ]; then echo -e "${size}${unit}\t${fname}"; break; fi; size=$((size/1024)); done; done'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias lsd='ls -F | grep /'
alias o='popd'
alias p='pushd'
alias push='git push -u origin master'
alias same="find . -type f -print0 | xargs -0 -n1 md5sum | sort -k 1,32 | uniq -w 32 -d --all-repeated=separate | sed -e 's/^[0-9a-f]*\ *//;'"
alias testunicode='perl -Mcharnames=:full -CS -wle '\''print "\N{EURO SIGN}"'\'''
alias x='exit'
#### end aliases ####

#### tmux shell init ####
tmux_count=`tmux ls | wc -l`
if [[ "$tmux_count" == "0" ]]; then
    tmux -2
else
    if [[ -z "$TMUX" ]]; then
        if [[ "$tmux_count" == "1" ]]; then
            session_id=1
        else
            session_id=`echo $tmux_count`
        fi
    tmux -2 new-session -d -s $session_id
    tmux -2 attach-session -t $session_id
    fi
fi
#### tmux init end ####

#### prompt stuff ####
function prompt_command {
let prompt_line=${LINES}
newPWD="${PWD}"
}

PROMPT_COMMAND=prompt_command

function load_out() {
  echo -n "$(uptime | sed -e "s/.*load average: \(.*\...\), \(.*\...\), \(.*\...\).*/\1/" -e "s/ //g")"
}

function load_color() {
  gray=0
  red=1
  green=2
  yellow=3
  blue=4
  magenta=5
  cyan=6
  white=7

  # Colour progression is important ...
  #   bold gray -> bold green -> bold yellow -> bold red ->-
  #   black on red -> bold white on red
  #
  # Then we have to choose the values at which the colours switch, with
  # anything past yellow being pretty important.

  tmp=$(echo $(load_out)*100 | bc)
  let load100=${tmp%.*}
  if [ ${load100} -lt 70 ]
  then
    tput bold ; tput setaf ${gray}
  elif [ ${load100} -ge 70 ] && [ ${load100} -lt 120 ]
  then
    tput bold ; tput setaf ${green}
  elif [ ${load100} -ge 120 ] && [ ${load100} -lt 200 ]
  then
    tput bold ; tput setaf ${yellow}
  elif [ ${load100} -ge 200 ] && [ ${load100} -lt 300 ]
  then
    tput bold ; tput setaf ${red}
  elif [ ${load100} -ge 300 ] && [ ${load100} -lt 500 ]
  then
    #tput setaf ${gray} ; tput setab ${red}
    tput setaf ${blue} ; tput setab ${red}
  else
    tput bold ; tput setaf ${white} ; tput setab ${red}
  fi
}

PS1="\[\033[\${prompt_line};0H\]\[\e[30;1m\](\[\$(load_color)\]\$(load_out)\[\e[0m\]\[\e[30;1m\])-(\[\[\e[32;1m\]\w\[\e[30;1m\])-(\[\[\e[32;1m\]\h\[\e[30;1m\])-(\[\e[32;1m\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files, \$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\e[30;1m\])-> \[\e[0m\]"
#### end prompt stuff ####

#### motd and fortune ####
# cat /etc/ssh/banner.txt
fortune futurama
#### end motd and fortune ####
