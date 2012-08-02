####################################################
# .zshrc file                                      #
#                                                  #
# in the titles, the brackets are for vim folding. #
####################################################

#### interactive shell check #### {
if [[ $- != *i* ]] ; then
    return
fi
#### end interactive check #### }

#### exports #### {
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=screen-256color
#### end exports #### }

#### zsh key bindings #### {
bindkey ";5C" forward-word
bindkey ";5D" backward-word
bindkey "^[3;5~" delete-char
bindkey "^[[3~" delete-char
bindkey '\e[1~' beginning-of-line       # home key
bindkey '\e[4~' end-of-line             # end key
bindkey -e
bindkey '\e[2~' overwrite-mode          # insert key to overwrite mode
#### end zsh key bindings #### }

#### zsh history #### {
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY           # append rather than overwrite history file.
setopt EXTENDED_HISTORY         # save timestamp and runtime information
setopt HIST_EXPIRE_DUPS_FIRST   # allow dups, but expire old ones when I hit HISTSIZE
setopt HIST_FIND_NO_DUPS        # don't find duplicates in history
setopt HIST_IGNORE_ALL_DUPS     # ignore duplicate commands regardless of commands in between
setopt HIST_IGNORE_DUPS         # ignore duplicate commands
setopt HIST_REDUCE_BLANKS       # leave blanks out
setopt HIST_SAVE_NO_DUPS        # don't save duplicates
setopt INC_APPEND_HISTORY       # write after each command
setopt SHARE_HISTORY            # share history between sessions
#### end zsh history #### }

#### ls colors zsh #### {
if [[ -x "`whence -p dircolors`" ]]; then
      eval `dircolors`
        alias ls='ls -F --color=auto'
    else
          alias ls='ls -F'
      fi
#### end ls colors #### }

#### zsh super globs #### {
setopt NO_CASE_GLOB             # case insensitive globbing
setopt NUMERIC_GLOB_SORT        # numeric glob sort
setopt extendedglob
unsetopt caseglob
#### end super globs #### }

#### misc zsh options #### {
setopt NO_BEEP                  # no more beeps
#### end misc zsh options #### }

#### aliases and functions #### {
# alias speak_date='espeak “Today is `/bin/date \”+%A, %d %B 20%y\”`”‘
# alias speak_time='espeak "Time is `/bin/date` \"+%H hours %M minutes %S seconds\""'
alias add='git add .'
alias commit='git commit .'
alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"
alias dud100='du -a --max-depth=1 | sort -n | awk '\''{if($1 > 102400) print $1/1024 "MB" " " $2 }'\'''
alias dud='du --max-depth=1 -h'
alias duf='du -sk * | sort -n | while read size fname; do for unit in k M G T P E Z Y; do if [ $size -lt 1024 ]; then echo -e "${size}${unit}\t${fname}"; break; fi; size=$((size/1024)); done; done'
alias irc='if [[ $USER == root || `ps -ef | egrep@ tmux | egrep -v egrep | wc -l` -eq 0  ]] ; then irssi ; else  tmux rename-window "irc" && irssi ; fi'
alias mail='if [[ $USER == root || `ps -ef | egrep tmux | egrep -v egrep | wc -l` -eq 0  ]] ; then mutt ; else tmux rename-window "emails" && mutt ; fi'
alias o='popd'
alias p='pushd'
alias push='git push origin master'
alias same="find . -type f -print0 | xargs -0 -n1 md5sum | sort -k 1,32 | uniq -w 32 -d --all-repeated=separate | sed -e 's/^[0-9a-f]*\ *//;'"
alias testunicode='perl -Mcharnames=:full -CS -wle '\''print "\N{EURO SIGN}"'\'''
alias x='exit'
function _force_rehash() { (( CURRENT == 1 )) && rehash ; return 1 }
function goog; { /usr/bin/links -g 'http://www.google.com/search?q='${(j:+:)*} }
function google; { /usr/bin/chromium 'http://www.google.com/search?q='${(j:+:)*} }
function h() { if [ -z "$*" ]; then history 1; else history 1 | egrep "$@"; fi; }
#### end aliases and functions #### }

#### tmux shell init #### {
if [[ $USER != root ]]; then
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
else
fi
#### tmux init end #### }

#### motd / fortune #### {
fortune futurama
#### end motd / fortune #### }

#### prompt #### {
PS1='%(!.%B%F{red}%n %B%F{blue}[%d] %B%F{red}%{☿%} %b%f%k.%B%F{green}%n@%m%k %B%F{blue}%1~ %# %b%f%k)'
#### end prompt #### }

#### testing area #### {
# from http://stackoverflow.com/questions/171563/whats-in-your-zshrc
function most_useless_use_of_zsh {
   local lines columns colour a b p q i pnew
   ((columns=COLUMNS-1, lines=LINES-1, colour=0))
   for ((b=-1.5; b<=1.5; b+=3.0/lines)) do
       for ((a=-2.0; a<=1; a+=3.0/columns)) do
           for ((p=0.0, q=0.0, i=0; p*p+q*q < 4 && i < 32; i++)) do
               ((pnew=p*p-q*q+a, q=2*p*q+b, p=pnew))
           done
           ((colour=(i/4)%8))
            echo -n "\\e[4${colour}m "
        done
        echo
    done
}
#### end testing area #### }
