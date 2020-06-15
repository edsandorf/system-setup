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
mkdir ~/downloads ~/public ~/software ~/shared

# Create symlinks from Google Drive (from default installation)
ln -nfs ~/Insync/edsandorf@gmail.com/Google\ Drive/desktop ~/desktop
ln -nfs ~/Insync/edsandorf@gmail.com/Google\ Drive/documents ~/documents
ln -nfs ~/Insync/edsandorf@gmail.com/Google\ Drive/music ~/music
ln -nfs ~/Insync/edsandorf@gmail.com/Google\ Drive/pictures ~/pictures
ln -nfs ~/Insync/edsandorf@gmail.com/Google\ Drive/software ~/software
ln -nfs ~/Insync/edsandorf@gmail.com/Google\ Drive/templates ~/templates
ln -nfs ~/Insync/edsandorf@gmail.com/Google\ Drive/videos ~/videos

# Put all shared folders from all services inside ~/Public
ln -nfs ~/Insync/edsandorf@gmail.com/Google\ Drive/shared/* ~/shared
ln -nfs ~/Insync/eds4@stir.ac.uk/OneDrive\ Biz/shared/* ~/shared
ln -nfs ~/Dropbox/public/* ~/shared


# Update the default XDG user directories
xdg-user-dirs-update --set DESKTOP ~/desktop
xdg-user-dirs-update --set DOCUMENTS ~/documents
xdg-user-dirs-update --set DOWNLOAD ~/downloads
xdg-user-dirs-update --set MUSIC ~/music
xdg-user-dirs-update --set PICTURES ~/pictures
xdg-user-dirs-update --set PUBLICSHARE ~/public
xdg-user-dirs-update --set TEMPLATES ~/templates
xdg-user-dirs-update --set VIDEOS ~/videos
