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
if [[ `tty` == *1* ]] && [[ "$EUID" -ne "0" ]]; then
    [[ -z `ps -ef | awk '/\/bin\/evilwm/'` ]] && { startx 2> /dev/null }
fi
#### end automata #### }

#### exports #### {
export EDITOR=/usr/bin/vi
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=screen-256color
export XDG_CONFIG_HOME="$HOME/.config"
#### end exports #### }

#### eix #### {
export EIX_LIMIT=0
#### end eix #### }

#### zsh key bindings #### {
# bindkey -v                              # vi mode for vi style keybindings
bindkey -e                                # emacs mode for emacs keybindings
bindkey "\eOd"    backward-word           # [Ctrl] [LeftArrow] move backward one word
bindkey "\e[1;3D" backward-word           # [Alt] [LeftArrow] move backward one word
bindkey "\e[1;5D" backward-word           # [Ctrl] [LeftArrow] move backward one word
bindkey "\e[5D"   backward-word           # [Esc] [LeftArrow] move backward one word
bindkey "\e\e[D"  backward-word           # [Ctrl] [LeftArrow] move backward one word
bindkey "^B"      backward-word           # [Ctrl] [b] move backward one word
bindkey "\eOH"    beginning-of-line       # [Home] go to beginning of line
bindkey "\e[1~"   beginning-of-line       # [Home] go to beginning of line
bindkey "\e[H"    beginning-of-line       # [Home] go to beginning of line
bindkey "^A"      beginning-of-line       # [Ctrl] [a] go to beginning of line
bindkey "^[[7~"   beginning-of-line       # [Home] go to beginning of line
bindkey "\e[3~"   delete-char             # [Delete] delete forward
bindkey "^[3;5~"  delete-char             # [Delete] delete forward
bindkey "^[[3~"   delete-char             # [Delete] delete forward
bindkey ";3C"     emacs-forward-word      # [Alt] [RightArrow] forward word
bindkey "^[[5C"   emacs-forward-word      # [Ctrl] [RightArrow] forward word
bindkey ";3D"     emacs-backward-word     # [Alt] [LeftArrow] backword word
bindkey "^[[5D"   emacs-backward-word     # [Ctrl] [LeftArrow] backword word
bindkey "\eOF"    end-of-line             # [End] go to end of line
bindkey "\e[4~"   end-of-line             # [End] go to end of line
bindkey "\e[F"    end-of-line             # [End] go to end of line
bindkey "^E"      end-of-line             # [Ctrl] [e] go to end of line
bindkey "^[[8~"   end-of-line             # [End] go to end of line
bindkey "\eOc"    forward-word            # [Ctrl] [RightArrow] move forward one word
bindkey "\e[1;3C" forward-word            # [Alt] [RightArrow] move forward one word
bindkey "\e[1;5C" forward-word            # [Ctrl] [RightArrow] move forward one word
bindkey "\e[5C"   forward-word            # [Esc] [RightArrow] move forward one word
bindkey "\e\e[C"  forward-word            # [Esc] [RightArrow] move forward one word
bindkey "^F"      forward-word            # [Ctrl] [f] move forward one word
bindkey "\e[5~"   history-search-backward
bindkey "\e[6~"   history-search-forward
bindkey "^R"      history-incremental-search-backward  # [Ctrl] [r] history incremental search backwards
bindkey "\e[2~"   quoted-insert           # [Insert] insert key
bindkey "^[[2~"   overwrite-mode          # insert key overwrite mode
#### end zsh key bindings #### }

#### zsh history #### {
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
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
setopt extended_glob
setopt globdots                 # lets files beginning with a "." match explicitly without specifying
unsetopt caseglob
#### end super globs #### }

#### misc zsh options #### {
#setopt CORRECT                  # spell checking
setopt NO_BEEP                  # no more beeps
setopt autocd                   # no more pesky cd to change dirs
#setopt correctall               # autocorrection of commands typed
#### end misc zsh options #### }

#### aliases and functions #### {
# alias speak_date='espeak “Today is `/bin/date \”+%A, %d %B 20%y\”`”‘
# alias speak_time='espeak "Time is `/bin/date` \"+%H hours %M minutes %S seconds\""'
alias -g E='|egrep '
alias -g G='|grep '
alias -s erb=vi
alias -s json=vi
alias -s rb=vi
alias 1g='openssl rand -base64 $(( 2**30 * 3/4 )) > test.img'
alias add='git add -p .'
alias commit='git commit .'
alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"
alias dud100='du -a --max-depth=1 | sort -n | awk '\''{if($1 > 102400) print $1/1024 "MB" " " $2 }'\'''
alias dud='du --max-depth=1 -h | sort -h'
alias duf='du -sk * | sort -n | while read size fname; do for unit in k M G T P E Z Y; do if [ $size -lt 1024 ]; then echo -e "${size}${unit}\t${fname}"; break; fi; size=$((size/1024)); done; done'
alias facts='elinks -dump randomfunfacts.com | sed -n '\''/^| /p'\'' | tr -d \|'
alias fchat='if [[ $USER == root || `ps -ef | egrep finch | egrep -v egrep | wc -l` -eq 1  ]] ; then finch ; else ; tmux rename-window "chat" && finch ; fi'
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
function _force_rehash() { (( CURRENT == 1 )) && rehash ; return 1 }
function checksum() { printf "FILE: `echo ${1}`\n" ; printf "SIZE: `ls -al ${1} | awk '{ print $5 }'` bytes\n" ; printf "MD5 : `md5sum ${1} | awk '{ print $1 }' | tr '[:lower:]' '[:upper:]'`\n" ; printf "SHA1: `sha1sum ${1} | awk '{ print $1 }' | tr '[:lower:]' '[:upper:]'`\n" }
function genpasswd() { if [ -z $1 ] ; then echo "need a character count" ; else tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${1} | xargs ; fi }
function genpasswd_strong() { if [ -z $1 ] ; then echo "need a character count" ; else tr -dc 'a-zA-Z0-9-_!@#$%^&*()_+{}|:<>?=' < /dev/urandom | head -c ${1} | xargs; fi }
function goog; { /usr/bin/links 'http://www.google.com/search?q='${(j:+:)*} }
function google; { /usr/bin/chromium 'http://www.google.com/search?q='${(j:+:)*} }
function h() { if [ -z "$*" ]; then history -d -i 1; else history -d -i 1 | egrep "$@"; fi; }
function smetric() { if [ -z $1 ] ; then echo "need a url" ; else curl -w '\nLookup time:\t%{time_namelookup}\nConnect time:\t%{time_connect}\nPreXfer time:\t%{time_pretransfer}\nStartXfer time:\t%{time_starttransfer}\n\nTotal time:\t%{time_total}\n\n' -o /dev/null -s ${1} ; fi }
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

#### ssh agent && reagent #### {
##if [[ "$EUID" -ne "0" ]]; then
##  eval `ssh-agent -s`
##  ssh-add ~/.ssh/work/id_rsa
##  ## ssh-reagent from http://tychoish.com/rhizome/9-awesome-ssh-tricks/
##  ssh-reagent () {
##    for agent in /tmp/ssh-*/agent.*; do
##    export SSH_AUTH_SOCK=$agent
##    if ssh-add -l 2>&1 > /dev/null; then
##      echo Found working SSH Agent:
##      ssh-add -l
##      return
##    fi
##  done
##  echo Cannot find ssh agent - maybe you should reconnect and forward it?
##  }
##fi
## end ssh-reagent
#### end ssh agent && re-agent #### }

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

#### sourcing of other files #### {
source ~/.awscreds.mine
#### end sourcing #### }
