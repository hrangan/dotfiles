#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

# invoke global X session script
xbindkeys
xmodmap ~/.xmodmap
. /etc/X11/Xsession
