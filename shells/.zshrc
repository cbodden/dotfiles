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

#### startx automata #### {
if [[ `tty` == *1* ]] && [[ "$EUID" -ne "0" ]] ; then
    [[ -z `ps -ef | awk '/\/bin\/evilwm/'` ]] && { startx 2> /dev/null }
fi
#### end automata #### }

#### exports #### {
export EDITOR=/usr/bin/vi
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color
export XDG_CONFIG_HOME="$HOME/.config"
#### end exports #### }

#### eix #### {
export EIX_LIMIT=0
#### end eix #### }

#### gpg ioctl fix ####
export GPG_TTY=$(tty)
#### end gpg ####

#### zsh key bindings #### {
bindkey -v                                # vi mode for vi style keybindings
bindkey -M vicmd '?' history-incremental-search-backward  # Better searching in command mode
bindkey -M vicmd '/' history-incremental-search-forward
bindkey "^[OA" up-line-or-beginning-search                # Beginning search with arrow keys
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search
bindkey -M vicmd v edit-command-line                      # Easier, more vim-like editor opening
bindkey -M vicmd "^V" edit-command-line                   # `v` is already mapped to visual mode, so we need to use a different key to open Vim
export KEYTIMEOUT=1                       # Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)

#  Mode indication
autoload -U colors && colors
function zle-line-init zle-keymap-select {
    _I_PMPT="%{$fg[red]%} [% INSERT]%  %{$reset_color%}"
    _N_PMPT="%{$fg[blue]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="%B${${KEYMAP/vicmd/${_N_PMPT}}/(main|viins)/${_I_PMPT}}$b"
    #RPS1="%B${${KEYMAP/vicmd/NORMAL}/(main|viins)/INSERT}%b"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

setopt transient_rprompt
#### end zsh key bindings #### }

#### zsh history #### {
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt APPEND_HISTORY                     # append rather than overwrite history file.
setopt EXTENDED_HISTORY                   # save timestamp and runtime information
setopt HIST_EXPIRE_DUPS_FIRST             # allow dups, but expire old ones when I hit HISTSIZE
setopt HIST_FIND_NO_DUPS                  # don't find duplicates in history
setopt HIST_IGNORE_ALL_DUPS               # ignore duplicate commands regardless of commands in between
setopt HIST_IGNORE_DUPS                   # ignore duplicate commands
setopt HIST_REDUCE_BLANKS                 # leave blanks out
setopt HIST_SAVE_NO_DUPS                  # don't save duplicates
setopt INC_APPEND_HISTORY                 # write after each command
setopt SHARE_HISTORY                      # share history between sessions
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
setopt NO_CASE_GLOB                       # case insensitive globbing
setopt NUMERIC_GLOB_SORT                  # numeric glob sort
setopt extended_glob
setopt globdots                           # lets files beginning with a "." match explicitly without specifying
unsetopt caseglob
#### end super globs #### }

#### misc zsh options #### {
setopt NO_BEEP                            # no more beeps
setopt autocd                             # no more pesky cd to change dirs
#### end misc zsh options #### }

#### prompt #### {
if [[ "$EUID" -ne "0" ]]; then
    # https://github.com/nojhan/liquidprompt
    source ~/.zsh/liquidprompt/liquidprompt
else
    # https://github.com/olivierverdier/zsh-git-prompt
    source ~/.zsh/git-prompt/zshrc.sh
    PS1='$(git_super_status) %(!.%B%F{red}%n %B%F{blue}[%d] %B%F{red}%{○%} %b%f%k.%B%F{green}%n@%m%k %B%F{blue}%1~ %# %b%f%k)'
fi
#### end prompt #### }

#### zsh plugins #### {
autoload -U compinit promptinit
compinit
promptinit; prompt gentoo
zstyle ':completion::complete:*' use-cache 1
plugins=(… zsh-completions)
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
### end zsh options #### }

#### aliases and functions #### {
# alias speak_date='espeak “Today is `/bin/date \”+%A, %d %B 20%y\”`”‘
# alias speak_time='espeak "Time is `/bin/date` \"+%H hours %M minutes %S seconds\""'
alias add='git add -p .'
alias commit='git commit .'
alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"
alias d='dirs -v'
alias did="vim +'normal Go' +'r!date' ~/did.txt"
alias facts='elinks -dump randomfunfacts.com | sed -n '\''/^| /p'\'' | tr -d \|'
alias irc='if [[ $USER == root || `ps -ef | egrep tmux | egrep -v egrep | wc -l` -eq 0  ]] ; then irssi ; else tmux rename-window "irc" && irssi ; fi'
alias l80='awk '\''length > 80 {print FILENAME " line " FNR "\n\t" $0}'\'' *'
alias lg='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
alias lockme='xscreensaver-command -lock && sudo /usr/sbin/hibernate'
alias mail='if [[ $USER == root || `ps -ef | egrep tmux | egrep -v egrep | wc -l` -eq 0  ]] ; then mutt ; else tmux rename-window "emails" && mutt ; fi'
alias o='popd'
alias p='pushd'
alias ps='ps --forest'
alias pull='git pull --rebase && facts'
alias push='git push origin master && facts'
alias ramme='xscreensaver-command -lock && sudo /usr/sbin/hibernate-ram'
alias same="find . -type f -print0 | xargs -0 -n1 md5sum | sort -k 1,32 | uniq -w 32 -d --all-repeated=separate | sed -e 's/^[0-9a-f]*\ *//;'"
alias speedtest='echo "scale=2; $(curl  --progress-bar -w "%{speed_download}" http://speedtest.newark.linode.com/100MB-newark.bin -o /dev/null) / 131072" | bc | xargs -I {} echo {} mbps'
alias testunicode='perl -Mcharnames=:full -CS -wle '\''print "\N{EURO SIGN}"'\'''
alias tstamp="gawk '{ print strftime(\"[%Y-%m-%d %H:%M:%S]\"), \$0 }'"
alias watchdd='sudo kill -USR1 $(pgrep "^dd") && watch -n5 -x sudo kill -USR1 $(pgrep "^dd")'
alias wserver='python -m SimpleHTTPServer 8080'
alias x='exit'

function tunnel() { if [ -z $1 ] ; then echo "need hostname" ; else ssh -f -N -M -S /tmp/file-${1} ${1} ; fi }
function killtunnel() { if [ -z $1 ] ; then echo "need hostname" ; else ssh -S /tmp/file-${1} -O exit ${1} ; fi }

function checksum() { printf "FILE: `echo ${1}`\n" ; printf "SIZE: `ls -al ${1} | awk '{ print $5 }'` bytes\n" ; printf "MD5 : `md5sum ${1} | awk '{ print $1 }' | tr '[:lower:]' '[:upper:]'`\n" ; printf "SHA1: `sha1sum ${1} | awk '{ print $1 }' | tr '[:lower:]' '[:upper:]'`\n" }
function genpasswd() { if [ -z $1 ] ; then echo "need a character count" ; else tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${1} | xargs ; fi }
function genpasswd_strong() { if [ -z $1 ] ; then echo "need a character count" ; else tr -dc 'a-zA-Z0-9-_!@#$%^&*()_+{}|:<>?=' < /dev/urandom | head -c ${1} | xargs; fi }
function h() { if [ -z "$*" ]; then history -d -i 1; else history -d -i 1 | egrep "$@"; fi; }
function smetric() { if [ -z $1 ] ; then echo "need a url" ; else curl -w '\nLookup time:\t%{time_namelookup}\nConnect time:\t%{time_connect}\nPreXfer time:\t%{time_pretransfer}\nStartXfer time:\t%{time_starttransfer}\n\nTotal time:\t%{time_total}\n\n' -o /dev/null -s ${1} ; fi }
function search; { xdg-open 'https://www.google.com/search?q='${(j:+:)*} }
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
if [[ $USER != root ]]; then
    ~/git/mine/dotfiles/motd.sh
else
    fortune futurama
fi
#### end motd / fortune #### }

#### colored man pages #### {
# as per : http://boredzo.org/blog/archives/2016-08-15/colorized-man-pages-understood-and-customized
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}
#### end colored man pages }
