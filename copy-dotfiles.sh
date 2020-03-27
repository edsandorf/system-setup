#!/bin/bash
#
# Description:
#   Cloning the .dofiles repo and making symlinks.
#   This should be done AFTER programs such as TeXStudio and Atom has been opened
#   for the first time.
#
# Author:
#   Erlend Dancke Sandorf <edsandorf [:at:] gmail.com>
#

cd ~
git clone https://github.com/edsandorf/.dotfiles.git
cd ~/.dotfiles

# git
ln -s .gitconfig ~/.gitconfig

# Conky
ln -s .conkyrc ~/.conkyrc

# .bashrc (not really necessary now that I am using fish)
ln -s .bashrc ~/.bashrc

# Config atom
rm ~/.atom/config.cson
ln -s config.cson ~/.atom/config.cson

# Fish shell config
ln -s .config.fish ~/.config/fish/config.fish

# ccache
mkdir ~/.ccache
ln -s ccache.conf ~/.ccache/ccache.conf

# Makevars
mkdir ~/.R
ln -s Makevars ~/.R/Makevars

# TeXStudio
rm ~/.config/texstudio/texstudio.ini
ln -s texstudio.ini ~/.config/texstudio/texstudio.ini

# Move the mimeapps.list
rm ~/.config/mimeapps.list
sudo ln -s mimeapps.list ~/.config/mimeapps.list
