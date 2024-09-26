#### Modeline and Notes #### {{{
# vim: set foldmarker={{{,}}} foldlevel=0 spell:
####################################################
# .zshrc file                                      #
#                                                  #
# in the titles, the brackets are for vim folding. #
####################################################
#### end modeline and notes }}}

#### interactive shell check #### {{{
if [[ $- != *i* ]] ; then
    return
fi
#### end interactive check #### }}}

#### startx automata #### {{{
if [[ `tty` == *1* ]] && [[ "$EUID" -ne "0" ]]
then
    [[ -z `ps -ef | grep dwm | grep -v grep` ]] \
        && { startx 2> /dev/null }
fi
#### end automata #### }}}

#### exports #### {{{
export XAUTHORITY=~/.Xauthority
export EDITOR=/usr/bin/vi
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export XDG_CONFIG_HOME="$HOME/.config"
export ZSH="$HOME/.oh-my-zsh"
#### end exports #### }}}

#### eix #### {{{
export EIX_LIMIT=0
#### end eix #### }}}

#### gpg ioctl fix #### {{{
export GPG_TTY=$(tty)
#### end gpg #### }}}

#### key bindings #### {{{
bindkey -v                                                # vi mode for vi style keybindings
bindkey -M vicmd '?' history-incremental-search-backward  # Better searching in command mode
bindkey -M vicmd '/' history-incremental-search-forward
bindkey "^[OA" up-line-or-beginning-search                # Beginning search with arrow keys
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search
bindkey -M vicmd v edit-command-line                      # Easier, more vim-like editor opening
bindkey -M vicmd "^V" edit-command-line                   # `v` is already mapped to visual mode, so we need to use a different key to open Vim
export KEYTIMEOUT=1                                       # Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)

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
#### end key bindings #### }}}

#### history #### {{{
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
#### end history #### }}}

#### ls colors #### {{{
if [[ -x "`whence -p dircolors`" ]]; then
    eval `dircolors`
    alias ls='ls -F --color=auto'
else
    alias ls='ls -F'
fi
#### end ls colors #### }}}

#### super globs #### {{{
setopt NO_CASE_GLOB                       # case insensitive globbing
setopt NUMERIC_GLOB_SORT                  # numeric glob sort
setopt extended_glob
setopt globdots                           # lets files beginning with a "." match explicitly without specifying
unsetopt caseglob
#### end super globs #### }}}

#### misc options #### {{{
setopt NO_BEEP                            # no more beeps
setopt autocd                             # no more pesky cd to change dirs
setopt correctall                         # auto-correction of the commands typed
#### end misc options #### }}}

#### zsh plugin source #### {{{
source $ZSH/oh-my-zsh.sh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh
#### end zsh plugin source #### }}}

#### zsh plugins #### {{{
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"  # suggestion highlight style
plugins+=(git vi-mode)                    # oh my zsh setting vi mode
autoload -U compinit promptinit           # enable tab-completion and advanced prompt
compinit                                  # enable tab-completion
promptinit; prompt gentoo                 # enable advanced prompt and activate gentoo prompt
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion::complete:*' use-cache 1
### end zsh options #### }}}

#### aliases #### {{{
# alias speak_date='espeak “Today is `/bin/date \”+%A, %d %B 20%y\”`”‘
# alias speak_time='espeak "Time is `/bin/date` \"+%H hours %M minutes %S seconds\""'
alias add='git add -p .'
alias commit='git commit .'
alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"
alias d='dirs -v'
alias did="vim +'normal Go' +'r!date' ~/did.txt"
alias facts="elinks -dump randomfunfacts.com | awk '/┌──/{ f = 1 } f; /└──/{ f = 0 }'"
alias irc='export TERM=tmux-256color ; tmux rename-window "weechat" ; weechat'
alias l80='awk '\''length > 80 {print FILENAME " line " FNR "\n\t" $0}'\'' *'
alias lg='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
alias lockme='xscreensaver-command -lock && sudo xset -display :0 dpms force off && sudo s2disk -r /dev/nvme0n1p2'
alias mail='if [[ $USER == root || `ps -ef | egrep tmux | egrep -v egrep | wc -l` -eq 0  ]] ; then mutt ; else tmux rename-window "emails" && mutt ; fi'
alias o='popd'
alias p='pushd'
alias ps='ps --forest'
alias pull='git pull --rebase && facts'
alias push='git push origin main && facts'
alias ramme='xscreensaver-command -lock && sudo xset -display :0 dpms force off && sudo s2ram --vbe_save --vbe_mode'
alias same="find . -type f -print0 | xargs -0 -n1 md5sum | sort -k 1,32 | uniq -w 32 -d --all-repeated=separate | sed -e 's/^[0-9a-f]*\ *//;'"
alias testunicode='perl -Mcharnames=:full -CS -wle '\''print "\N{EURO SIGN}"'\'''
alias tp='~/git/mine/scripts/touchpad.sh'
alias tstamp="gawk '{ print strftime(\"[%Y-%m-%d %H:%M:%S]\"), \$0 }'"
alias watchdd='sudo kill -USR1 $(pgrep "^dd") && watch -n5 -x sudo kill -USR1 $(pgrep "^dd")'
alias wserver='python -m SimpleHTTPServer 8080'
alias x='exit'
#### end aliases #### }}}

#### functions #### {{{{{
function checksum() { printf "FILE: `echo ${1}`\n" ; printf "SIZE: `ls -al ${1} | awk '{ print $5 }'` bytes\n" ; printf "MD5 : `md5sum ${1} | awk '{ print $1 }' | tr '[:lower:]' '[:upper:]'`\n" ; printf "SHA1: `sha1sum ${1} | awk '{ print $1 }' | tr '[:lower:]' '[:upper:]'`\n" }
function genpasswd() { if [ -z $1 ] ; then echo "need a character count" ; else LC_ALL=C tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${1} | xargs ; fi }
function genpasswd_strong() { if [ -z $1 ] ; then echo "need a character count" ; else LC_ALL=C tr -dc 'a-zA-Z0-9-_!@#$%^&*()_+{}|:<>?=' < /dev/urandom | head -c ${1} | xargs; fi }
function h() { if [ -z "$*" ]; then history -d -i 1; else history -d -i 1 | egrep "$@"; fi; }
function killtunnel() { if [ -z $1 ] ; then echo "need hostname" ; else ssh -S /tmp/file-${1} -O exit ${1} ; fi }
function myip() { curl https://ipinfo.io/$(curl https://ipinfo.io/ip) -w "\n" }
function search_google; { xdg-open 'https://www.google.com/search?q='${(j:+:)*} }
function search_ip() { curl https://ipinfo.io/${1} -w "\n" }
function smetric() { if [ -z $1 ] ; then echo "need a url" ; else curl -w '\nLookup time:\t%{time_namelookup}\nConnect time:\t%{time_connect}\nPreXfer time:\t%{time_pretransfer}\nStartXfer time:\t%{time_starttransfer}\n\nTotal time:\t%{time_total}\n\n' -o /dev/null -s ${1} ; fi }
function tor_address() { curl --socks5 127.0.0.1:9050 http://ifconfig.me/ -w "\n" }
function tor_route() { printf "%s\n" "authenticate \"\"" "signal newnym" "quit" | nc 127.0.0.1 9051 }
function tunnel() { if [ -z $1 ] ; then echo "need hostname" ; else ssh -f -N -M -S /tmp/file-${1} ${1} ; fi }
function whatismyip() { curl https://ipinfo.io/$(curl https://ipinfo.io/ip) -w "\n" }
#### functions #### }}}}}

#### tmux shell init #### {{{
if [[ $USER != root ]]; then
    tmux_count=`tmux ls | wc -l`
    if [[ "$tmux_count" == "0" ]]
    then
        tmux -2
    else
        if [[ -z "$TMUX" ]]
        then
            if [[ "$tmux_count" == "1" ]]
            then
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
#### tmux init end #### }}}

#### motd / fortune #### {{{
if [[ $USER != root ]]; then
    ~/git/mine/dotfiles/motd.sh
else
    fortune futurama
fi
#### end motd / fortune #### }}}

#### colored man pages #### {{{
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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/cbodden/google-cloud-sdk/path.zsh.inc' ]
then
    . '/home/cbodden/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/cbodden/google-cloud-sdk/completion.zsh.inc' ]
then
    . '/home/cbodden/google-cloud-sdk/completion.zsh.inc'
fi

PATH="/home/cbodden/.google-drive-upload/bin:/home/cbodden/.cargo/bin:${PATH}"


# QT font scaling
export QT_SCALE_FACTOR=1.25

