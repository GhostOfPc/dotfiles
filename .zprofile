#User directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

#System directories
export XDG_DATA_DIRS="/usr/local/share:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"
export XDG_CONFIG_DIRES="/etc/xdg"
export ZDOTDIR=$HOME/.config/zsh

# Applications
export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME"/bash-completion/bash_completion
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export FFMPEG_DATADIR="$XDG_CONFIG_HOME"/ffmpeg
#export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export KDEHOME="$XDG_CONFIG_HOME"/kde
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
#export XCOMPOSEFILE="$XDG_CONFIG_HOME"/X11/xcompose
#export XCOMPOSECACHE="$XDG_CACHE_HOME"/X11/xcompose
#export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
#export XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverrc
#export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
#export HISTFILE="$XDG_CACHE_HOME"/zsh/history
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

#Add .local/bin to the environment variables path
export PATH=$HOME/.local/bin:/usr/local/bin:$HOME/tinyMediaManager:$HOME/Applications:$PATH

# Unify the gtk and qt5 themes
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=0

# Default applications
export BROWSER="chromium"
export WM="awesome"
export EDITOR="nvim"
export TERMINAL="kitty"
export IMAGE="sxiv"
export VIDEO="mpv"

# Configure hardware video acceleration
export LIBVA_DRIVER_NAME=radeonsi kdenlive obs mpv ffmpeg
export VDPAU_DRIVER=radeonsi
export MOZ_Z11_EGL=1

#Login automatically after typing password
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
