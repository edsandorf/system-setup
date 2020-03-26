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

# Utility packages
yay -Su fish neofetch chromium ranger zotero atom insync dropbox\
conky git-lfs gitg pdftk qpdf tldr ccache jdk

# Python packages
yay -Su python-gdal python-yaml python-jinja python-psycopg2 python-owslib\
python-numpy python-pygments

# Important libraries for spatial applications
yay -Su gdal udunits postgis jdk-openjdk openjdk-src

# Texlive and pandoc
yay -Su texlive-core texstudio pandoc pandoc-citeproc pandoc-crossref

# R
yay -Su libopenblas r rstudio-desktop-bin radian

# Julia
yay -Su julia

# Packages enabling spatial analysis
yay -Su jq gcc-fortran tk nlopt gsl v8-3.14

# Other Packages
yay -Su spotify audacity blender gimp deluge obs-studio virtualbox

sudo pacman -R firefox kate
