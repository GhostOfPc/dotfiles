# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/hisham/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="awesome-patched"

plugins=(
	 git
	 zsh-autosuggestions
	 zsh-syntax-highlighting
	 colored-man-pages
	 web-search
	 )

source $ZSH/oh-my-zsh.sh


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Aliases
alias u="sudo pacman -Syyu"
alias uy="yay -Syu"
alias c="checkupdates"
alias srh="pacman -Ss"
alias ins="sudo pacman -S"
alias rmv="sudo pacman -R"
alias yi="yay -S"
alias ys="yay -Ss"
alias ltime="sudo timeshift --list"
alias dels="sudo timeshift --delete --snapshot"
alias cres="sudo timeshift --create --comments"
alias purge="sudo pacman -Rcns $(pacman -Qtdq)"
alias ex="exa --icons -lah --color=always --group-directories-first"
alias tra="transmission-remote -a \""
alias tr="transmission-remote "
alias trl="transmission-remote -l"
alias v="nvim"
alias w="curl wttr.in"
alias s="ssh 192.168.0.100 -p 22"
date +%A\ %d\ %B\ %Y\ %H:%M 
uname -nrm
uptime -p | sed "s/up\s/Elapsed Time: /;s/hours,\s/hs:/g;s/minutes/min/"
alias config='/usr/bin/git --git-dir=/home/hisham/dotfiles/ --work-tree=/home/hisham'
alias pic='/usr/bin/git --git-dir=/home/hisham/Pictures/ --work-tree=/home/hisham/Pictures'
