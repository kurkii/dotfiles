#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi
# dwmbar
/home/simon/dwm-bar/dwm_bar.sh &
# keyboard layout
setxkbmap -layout gb &

# compositor
picom -f -b --unredir-if-possible --vsync --use-damage & 

# wallpaper
nitrogen --restore &

#loop
while true; do
	dwm >/dev/null 2>&1
done
# gnome keyring
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK &
#qt dark mode
QTWEBENGINE_CHROMIUM_FLAGS=--blink-settings=darkMode=4,darkModeImagePolicy=2

# execute dwm
exec dwm

