# /etc/skel/.bashrc

if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Put your fun stuff here.
tmux_count=`tmux ls | wc -l`
if [[ "$$tmux_count" == "0" ]]; then
	tmux -2
else
	if [[ -z "$TMUX" ]]; then
		if [[ "$tmux_count" == "1" ]]; then
			session_id=1
		else
			session_id=`echo $tmux_count`
		fi
	tmux new-session -d -s $session_id
	tmux attach-session -t $session_id
	fi
fi

alias x="exit"
alias same="find . -type f -print0 | xargs -0 -n1 md5sum | sort -k 1,32 | uniq -w 32 -d --all-repeated=separate | sed -e 's/^[0-9a-f]*\ *//;'"
export TERM='xterm-256color'
alias lsd="ls -aF | egrep /"
export LC_ALL=C
alias svndown="svn co http://test1.ayisnap.com/config/trunk"
export EDITOR=/usr/bin/vim
alias p='pushd'
alias o='popd'




#### prompt ####
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
    tput setaf ${gray} ; tput setab ${red}
  else
    tput bold ; tput setaf ${white} ; tput setab ${red}
  fi
}

PS1="\[\033[\${prompt_line};0H\]\[\e[30;1m\](\[\$(load_color)\]\$(load_out)\[\e[0m\]\[\e[30;1m\])-(\[\[\e[32;1m\]\h\[\e[30;1m\])-(\[\[\e[32;1m\]\w\[\e[30;1m\])-(\[\e[32;1m\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files, \$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\e[30;1m\])-> \[\e[0m\]"

cat /etc/ssh/banner.txt
fortune futurama
