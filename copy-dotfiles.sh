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
rm ~/.gitconfig
ln -nfs ~/.dotfiles/.gitconfig ~/.gitconfig

# Conky
rm ~/.conkyrc
ln -nfs ~/.dotfiles/.conkyrc ~/.conkyrc

# .bashrc (not really necessary now that I am using fish)
rm ~/.bashrc
ln -nfs ~/.dotfiles/.bashrc ~/.bashrc

# Config atom
rm ~/.atom/config.cson
ln -nfs ~/.dotfiles/config.cson ~/.atom/config.cson

# Fish shell config
rm ~/.config/fish/config.fish
ln -nfs ~/.dotfiles/.config.fish ~/.config/fish/config.fish

# ccache
mkdir ~/.ccache
ln -nfs ~/.dotfiles/ccache.conf ~/.ccache/ccache.conf

# Makevars
mkdir ~/.R
ln -nfs ~/.dotfiles/Makevars ~/.R/Makevars

# TeXStudio
rm ~/.config/texstudio/texstudio.ini
ln -nfs ~/.dotfiles/texstudio.ini ~/.config/texstudio/texstudio.ini

# Move the mimeapps.list
rm ~/.config/mimeapps.list
sudo ln -nfs ~/.dotfiles/mimeapps.list ~/.config/mimeapps.list
