#!/bin/bash
#
# Description:
#   Installs packages from the official Manjaro repositories
#
# Author:
#   Erlend Dancke Sandorf <edsandorf [:at:] gmail.com>
#
# Usage:
#   Install and use yay: sudo pacman -Syu yay
#   Make sure that Java 8 is available: 'sudo archlinux-java set java-8-openjdk'
#
# Sources:
#   https://pat-s.me/post/arch-install-guide-for-r/

sudo pacman -Syu --needed base-devel yay

# Utility packages
yay -Syu fish neofetch chromium ranger zotero atom insync dropbox \
conky git-lfs gitg pdftk qpdf tldr ccache jdk jupyter downgrade \
ranger xclip seahorse polybar

# Security and VPN
yay -Syu firewalld wireguard

# Python packages
yay -Syu python-gdal python-yaml python-jinja python-psycopg2 python-owslib \
python-numpy python-pygments

# Important libraries for spatial applications
yay -Syu gdal udunits postgis jdk-openjdk openjdk-src

# Texlive and pandoc
yay -Syu texlive-core texstudio pandoc pandoc-citeproc pandoc-crossref

# R
yay -Syu libopenblas r rstudio-desktop-bin rstudio-server radian

# Julia
yay -Syu julia

# Packages enabling spatial analysis
yay -Syu jq gcc-fortran tk nlopt gsl v8-3.14

# Other Packages
yay -Syu spotify audacity blender gimp deluge obs-studio virtualbox teams zoom

sudo pacman -R firefox-gnome-theme-maia firefox empathy evolution gufw gnome-maps hexchat
