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

#### cgroup shell init #### {
# if [[ -d /sys/fs/cgroup/cpu ]]; then
#     cdir=/sys/fs/cgroup/cpu
#     mkdir -p -m 0700 "$cdir"/user/$$ >/dev/null 2>&1
#     echo $$ >"$cdir"/user/$$/tasks
#     echo 1 >"$cdir"/user/$$/notify_on_release
#     unset -v cdir
# fi
#### cgroup shell init #### }

#### exports #### {
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=screen-256color
export XDG_CONFIG_HOME="$HOME/.config"
#### end exports #### }

#### zsh key bindings #### {
# bindkey -v                            # vi mode for vi style keybindings
bindkey ';3C' emacs-forward-word        # <alt><right arrow> forward word
bindkey ';3D' emacs-backward-word       # <alt><left arrow> backword word
bindkey '^A' beginning-of-line          # ctrl-a beginning of line binding
bindkey '^B' backward-word              # ctrl-b backward words
bindkey '^E' end-of-line                # ctrl-e end of line binding
bindkey '^F' forward-word               # ctrl-f forward words
bindkey '^R' history-incremental-search-backward        # ctrl-r history incremental search backwards
bindkey '^[[2~' overwrite-mode          # insert key overwrite mode
bindkey '^[[3~' delete-char             # delete key fix
bindkey '^[[5C' emacs-forward-word      # <ctrl><right arrow> forward word
bindkey '^[[5D' emacs-backward-word     # <ctrl><left arrow> backword word
bindkey '^[[7~' beginning-of-line       # home key
bindkey '^[[8~' end-of-line             # end key
bindkey -e                              # emacs mode for emacs style keybindings
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
setopt extended_glob
setopt extendedglob
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
alias add='git add .'
alias commit='git commit .'
alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"
alias dud100='du -a --max-depth=1 | sort -n | awk '\''{if($1 > 102400) print $1/1024 "MB" " " $2 }'\'''
alias dud='du --max-depth=1 -h | sort -h'
alias duf='du -sk * | sort -n | while read size fname; do for unit in k M G T P E Z Y; do if [ $size -lt 1024 ]; then echo -e "${size}${unit}\t${fname}"; break; fi; size=$((size/1024)); done; done'
alias facts='elinks -dump randomfunfacts.com | sed -n '\''/^| /p'\'' | tr -d \|'
alias fchat='if [[ $USER == root || `ps -ef | egrep finch | egrep -v egrep | wc -l` -eq 1  ]] ; then finch ; else ; tmux rename-window "chat" && finch ; fi'
alias irc='if [[ $USER == root || `ps -ef | egrep tmux | egrep -v egrep | wc -l` -eq 0  ]] ; then irssi ; else tmux rename-window "irc" && irssi ; fi'
alias lg='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
alias mail='if [[ $USER == root || `ps -ef | egrep tmux | egrep -v egrep | wc -l` -eq 0  ]] ; then mutt ; else tmux rename-window "emails" && mutt ; fi'
alias o='popd'
alias p='pushd'
alias ps='ps --forest'
alias pull='git pull --rebase && facts'
alias push='git push origin master && facts'
alias same="find . -type f -print0 | xargs -0 -n1 md5sum | sort -k 1,32 | uniq -w 32 -d --all-repeated=separate | sed -e 's/^[0-9a-f]*\ *//;'"
alias testunicode='perl -Mcharnames=:full -CS -wle '\''print "\N{EURO SIGN}"'\'''
alias wserver='python -m SimpleHTTPServer 8080'
alias x='exit'
function _force_rehash() { (( CURRENT == 1 )) && rehash ; return 1 }
function checksum() { printf "FILE: `echo ${1}`\n" ; printf "SIZE: `ls -al ${1} | awk '{ print $5 }'` bytes\n" ; printf "MD5 : `md5sum ${1} | awk '{ print $1 }' | tr '[:lower:]' '[:upper:]'`\n" ; printf "SHA1: `sha1sum ${1} | awk '{ print $1 }' | tr '[:lower:]' '[:upper:]'`\n" }
function genpasswd() { if [ -z $1 ] ; then echo "need a character count" ; else tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${1} | xargs ; fi }
function genpasswd_strong() { if [ -z $1 ] ; then echo "need a character count" ; else tr -dc 'a-zA-Z0-9-_!@#$%^&*()_+{}|:<>?=' < /dev/urandom | head -c ${1} | xargs; fi }
function goog; { /usr/bin/links 'http://www.google.com/search?q='${(j:+:)*} }
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
if [[ "$EUID" -ne "0" ]]; then
  # https://github.com/nojhan/liquidprompt
  source ~/.zsh/liquidprompt/liquidprompt
else
  # https://github.com/olivierverdier/zsh-git-prompt
  source ~/.zsh/git-prompt/zshrc.sh
  PS1='$(git_super_status) %(!.%B%F{red}%n %B%F{blue}[%d] %B%F{red}%{☿%} %b%f%k.%B%F{green}%n@%m%k %B%F{blue}%1~ %# %b%f%k)'
fi
#### end prompt #### }

#### ssh-reagent from http://tychoish.com/rhizome/9-awesome-ssh-tricks/ {
ssh-reagent () {
    for agent in /tmp/ssh-*/agent.*; do
        export SSH_AUTH_SOCK=$agent
        if ssh-add -l 2>&1 > /dev/null; then
            echo Found working SSH Agent:
            ssh-add -l
            return
        fi
    done
echo Cannot find ssh agent - maybe you should reconnect and forward it?
}
#### end ssh-reagent }

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

export PERL_LOCAL_LIB_ROOT="$PERL_LOCAL_LIB_ROOT:/home/cbodden/perl5";
export PERL_MB_OPT="--install_base /home/cbodden/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/cbodden/perl5";
export PERL5LIB="/home/cbodden/perl5/lib/perl5:$PERL5LIB";
export PATH="/home/cbodden/perl5/bin:$PATH";
