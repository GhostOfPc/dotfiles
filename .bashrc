#
# ~/.bashrc
#
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH
export BROWSER="firefox"
export EDITOR="nvim"
export TERMINAL="kitty"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\033[34m\]\W \[\033[37m\]'

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

#shopt
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases

# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;      
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

set -o vi


# Aliases
alias p="sudo pacman --color always"
alias y="yay --color always"
alias ltime="sudo timeshift --list"
alias dels="sudo timeshift --delete --snapshot"
alias cres="sudo timeshift --create --comments"
alias purge="sudo pacman -Rcns $(pacman -Qtdq)"
alias ls="exa --icons -lah --color=always --group-directories-first"
alias v="nvim"
alias w="curl wttr.in"
alias c="checkupdates"
alias du="dust -r"
alias df="df -h"
alias lf="lfrun"
alias addT="transmission-remote -a"
alias addM="transmission-remote -a \""
alias lisT="watch -n 1 transmission-remote -l"
alias myt="mpv --ytdl-format=\""
alias ytls="youtube-dl --list-format"
alias n="ncmpcpp"
alias ls='exa --icons -lah --color=always --group-directories-first'
alias config='/usr/bin/git --git-dir=/home/hisham/.cfg/ --work-tree=/home/hisham'

#Free memory
alias fm1="sync; echo 1 > /proc/sys/vm/drop_caches"
alias fm2="sync; echo 2 > /proc/sys/vm/drop_caches"
alias fm3="sync; echo 3 > /proc/sys/vm/drop_caches"




color_test.sh
width=78 truecolor.sh
date +%A\ %d\ %B\ %Y\ %H:%M 
uname -nrm
uptime -p | sed "s/up\s/Elapsed Time: /;s/hours,\s/hs:/g;s/minutes/min/"
