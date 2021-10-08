# Prompt
preexec() {
    cmd_start="$SECONDS"
}
precmd() {
  local cmd_end="$SECONDS"
  elapsed=$((cmd_end-cmd_start))
  PS1="%F{magenta}%n%f%F{green}@%f%F{blue}%m%f%F{yellow}[took $elapsed%ss]%f%F{red} %~ %#%f "
}

setopt autocd # Automaticaly cd into typed directory.

# Colored man pages
function man() {
	env \
		LESS_TERMCAP_md=$(tput bold; tput setaf 4) \
		LESS_TERMCAP_me=$(tput sgr0) \
		LESS_TERMCAP_mb=$(tput blink) \
		LESS_TERMCAP_us=$(tput setaf 2) \
		LESS_TERMCAP_ue=$(tput sgr0) \
		LESS_TERMCAP_so=$(tput smso) \
		LESS_TERMCAP_se=$(tput rmso) \
		PAGER="${commands[less]:-$PAGER}" \
		man "$@"
}


# The following lines were added by compinstall
zstyle ':completion:*' completer _menu _expand _complete _correct _approximate
zstyle ':completion:*' completions 0
zstyle ':completion:*' glob 0
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' max-errors 10
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/home/hisham/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install

# History configuration
HISTFILE=~/.cache/zsh/history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history

# Set the machine hostname
HOSTNAME=$HOST

# Use vi-mode
bindkey -v

# End of lines configured by zsh-newuser-install
# Aliases
[[ -f "$HOME/.config/aliases" ]] && source "$HOME/.config/aliases"

# Startup commands
#color_test.sh
shuf -n 1 /home/hisham/.local/share/quotes | lolcat
#shuf -n 1 /home/hisham/.local/share/quotes | fribidi --nobreak | lolcat
date +%A\ %d\ %B\ %Y\ %H:%M 
uname -nrm
uptime -p | sed "s/up\s/Elapsed Time: /;s/hours,\s/hs:/g;s/minutes/min/"

# Autosuggestion and syntax highlighting
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
