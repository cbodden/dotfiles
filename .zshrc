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

#### zsh key bindings ####
bindkey -e
bindkey ";5C" forward-word
bindkey ";5D" backward-word
#### end zsh key bindings ####

#### zsh history ####
# http://www.lowlevelmanager.com/2012/04/zsh-history-extend-and-persist.html
HISTFILE=$HOME/.zsh_history    # enable history saving on shell exit
HISTSIZE=10000                 # lines of history to maintain memory
SAVEHIST=10000                 # lines of history to maintain in history file.
setopt APPEND_HISTORY          # append rather than overwrite history file.
setopt EXTENDED_HISTORY        # save timestamp and runtime information
setopt HIST_EXPIRE_DUPS_FIRST  # allow dups, but expire old ones when I hit HISTSIZE
setopt HIST_REDUCE_BLANKS       # leave blanks out
setopt SHARE_HISTORY            # share history between sessions
#### end zsh history ####

#### ls colors ####
if [[ -x "`whence -p dircolors`" ]]; then
      eval `dircolors`
        alias ls='ls -F --color=auto'
    else
          alias ls='ls -F'
      fi
#### end ls colors ####

#### zsh super globs ####
setopt extendedglob
unsetopt caseglob
#### end super globs ####

#### aliases ####
# alias speak_date='espeak “Today is `/bin/date \”+%A, %d %B 20%y\”`”‘
# alias speak_time='espeak "Time is `/bin/date` \"+%H hours %M minutes %S seconds\""'
alias dud100='du -a --max-depth=1 | sort -n | awk '\''{if($1 > 102400) print $1/1024 "MB" " " $2 }'\'''
alias dud='du --max-depth=1 -h'
alias duf='du -sk * | sort -n | while read size fname; do for unit in k M G T P E Z Y; do if [ $size -lt 1024 ]; then echo -e "${size}${unit}\t${fname}"; break; fi; size=$((size/1024)); done; done'
alias irc='tmux rename-window "irc" && irssi'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias lsd='ls -F | grep /'
alias mail='tmux rename-window "emails" && mutt'
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

#### motd and fortune ####
fortune futurama
#### end motd and fortune ####

#### prompt begin ####
PS1='%B%F{green}%n@%m%k %B%F{blue}%1~ %# %b%f%k'
#### end prompt ####
