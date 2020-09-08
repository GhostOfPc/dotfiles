export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR=$HOME/.config/zsh
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority

#Add .local/bin to the environment variables path
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

# Unify the gtk and qt5 themes
export QT_QPA_PLATFORMTHEME="qt5ct"

# Default applications
export BROWSER="firefox"
export WM="awesome"
export EDITOR="nvim"
export TERMINAL="kitty"
export IMAGE="sxiv"
export VIDEO="mpv"

# Path to your oh-my-zsh installation.
export ZSH="/home/hisham/.oh-my-zsh"

# Login automatically after typing password
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
