export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR=$HOME/.config/zsh
#export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
#export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export HISTFILE="$XDG_CACHE_HOME"/zsh/history
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export XCOMPOSEFILE="$XDG_CONFIG_HOME"/X11/xcompose
export XCOMPOSECACHE="$XDG_CACHE_HOME"/X11/xcompose

#Add .local/bin to the environment variables path
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

# Unify the gtk and qt5 themes
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=0

# Default applications
export BROWSER="brave"
export WM="awesome"
export EDITOR="nvim"
export TERMINAL="kitty"
export IMAGE="sxiv"
export VIDEO="mpv"

# Configure hardware video acceleration
export LIBVA_DRIVER_NAME=radeonsi kdenlive obs mpv ffmpeg
export VDPAU_DRIVER=radeonsi
export MOZ_Z11_EGL=1

# Login automatically after typing password
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi


