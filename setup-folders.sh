#!/bin/bash
#
# Description:
#   Setting up top level folder structure for ~/ and defining symlinks to
#   various cloud services
#
# Author:
#   Erlend Dancke Sandorf <edsandorf [:at:] gmail.com>
#
# Resources:
#   https://wiki.archlinux.org/index.php/XDG_user_directories
#

# Remove the default folders from home
rm -drf ~/Desktop ~/Documents ~/Downloads ~/Music ~/Pictures ~/Public ~/Templates ~/Videos

# Make the remaining folders
mkdir ~/downloads ~/public ~/software

# Create symlinks from Google Drive (from default installation)
ln -s ~/Insync/edsandorf@gmail.com/Google\ Drive/desktop ~/desktop
ln -s ~/Insync/edsandorf@gmail.com/Google\ Drive/documents ~/documents
ln -s ~/Insync/edsandorf@gmail.com/Google\ Drive/music ~/music
ln -s ~/Insync/edsandorf@gmail.com/Google\ Drive/pictures ~/pictures
ln -s ~/Insync/edsandorf@gmail.com/Google\ Drive/software ~/software
ln -s ~/Insync/edsandorf@gmail.com/Google\ Drive/templates ~/templates
ln -s ~/Insync/edsandorf@gmail.com/Google\ Drive/videos ~/videos

# Put all shared folders from all services inside ~/Public
ln -s ~/Insync/edsandorf@gmail.com/Google\ Drive/public/* ~/public
ln -s ~/Dropbox/public/* ~/public

# Update the default XDG user directories
xdg-user-dirs-update --set DESKTOP ~/desktop
xdg-user-dirs-update --set DOCUMENTS ~/documents
xdg-user-dirs-update --set DOWNLOAD ~/downloads
xdg-user-dirs-update --set MUSIC ~/music
xdg-user-dirs-update --set PICTURES ~/pictures
xdg-user-dirs-update --set PUBLICSHARE ~/public
xdg-user-dirs-update --set TEMPLATES ~/templates
xdg-user-dirs-update --set VIDEOS ~/videos
