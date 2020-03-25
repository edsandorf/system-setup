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

# Fish shell config
ln -s .config.fish ~/.config/fish/config.fish

# Makevars
