#!/bin/bash
#
#
#
#


#-------------------------------------------------------------------------------
# Check whether we are running the script as root
#-------------------------------------------------------------------------------
if [ "$(whoami)" != "root" ]; then
  whiptail --msgbox "The script must be run as root. Use sudo ./install-and-setup-utility.sh" 20 60 1
  exit
fi

# Define the install packages function
install_pkgs() {
  while IFS= read -r pkg; do
    if dpkg --get-selections | grep -q "^$pkg[[:space:]]*install$" >/dev/null; then
      echo -e "\e[33m$pkg is already installed.\e[0m"
    else
      # Check the exit status of the install
      if apt-get -qq install $pkg; then
        echo -e "\e[32m$pkg successfully installed!\e[0m"
      else
        echo -e "\e[31mFailed to install $pkg\e[0m"
      fi
    fi
  done < "$1"
}

#-------------------------------------------------------------------------------
# Define the full update and upgrade function
#-------------------------------------------------------------------------------
do_update_and_upgrade() {
  echo "0"
  echo "Running autoclean"
  apt-get autoclean -y

  echo "20"
  echo "Removing old package dependencies"
  apt-get autoremove -y

  echo "40"
  echo "Updating package repository"
  apt-get update

  echo "60"
  echo "Upgrading all packages"
  apt-get -qq --yes dist-upgrade

  echo "80"
  echo "Removing failed installations"
  apt-get -f install -y

  echo "100"
  echo "Complete"
  sleep 0.2
}

#-------------------------------------------------------------------------------
# Install R
#-------------------------------------------------------------------------------
install_r() {
  if grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep r-project; then
    echo -e "\e[36mAlready added to sources.list\e[0m"
  else
    # CRAN key
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
    # RStudio key
    gpg --keyserver keys.gnupg.net --recv-keys 3F32EE77E331692F
    cp /etc/apt/sources.list /etc/apt/sources.list.bak
    echo "deb https://cloud.r-project.org/bin/linux/ubuntu eoan-cran35/" | sudo tee -a /etc/apt/sources.list
    apt-get update
  fi

  # Install R and OpenBLAS
  echo -e "\e[36mInstalling OpenBLAS and R\e[0m"
  install_pkgs pkgs/r

  # Check if RStudio is installed
  if dpkg --get-selections | grep -q "^rstudio[[:space:]]*install$" >/dev/null; then
    echo -e "\e[33mRStudio is already installed.\e[0m"
  else
    wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.2.5033-amd64.deb -P ~/Downloads
    gdebi ~/Downloads/rstudio-1.2.5033-amd64.deb
    rm ~/Downloads/rstudio-1.2.5033-amd64.deb
    echo -e "\e[32mRStudio successfully installed\e[0m"
  fi
}

#-------------------------------------------------------------------------------
# Install Julia
#-------------------------------------------------------------------------------
install_julia() {
  install_pkgs pkgs/julia
}

#-------------------------------------------------------------------------------
# Install Ruby
#-------------------------------------------------------------------------------
install_ruby() {
  install_pkgs pkgs/ruby
}

#-------------------------------------------------------------------------------
# Install Anaconda Python
#-------------------------------------------------------------------------------
install_python() {
  if [ -d /home/edsandorf/anaconda3 ]; then
    echo -e "\e[33mAnaconda is already installed on the system\e[0m"
  else
    install_pkgs pkgs/python

    # Download Anaconda Python
    wget https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh -P ~/Downloads
    bash ~/Downloads/Anaconda3-2019.10-Linux-x86_64.sh
    rm ~/Downloads/Anaconda3-2019.10-Linux-x86_64.sh

    # Set the conda config
    conda config --set changeps1 False
  fi
}

#-------------------------------------------------------------------------------
# Install TeXLive and TexStudio
#-------------------------------------------------------------------------------
install_tex() {
  install_pkgs pkgs/tex
}

#-------------------------------------------------------------------------------
# Install Atom
#-------------------------------------------------------------------------------
install_atom() {
  if grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep atom; then
    echo -e "\e[36mAlready added to sources.list\e[0m"
  else
    # ATOM key
    wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | apt-key add -
    touch /etc/apt/sources.list.d/atom.list
    echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" | tee -a /etc/apt/sources.list.d/atom.list
    apt-get update
  fi

  install_pkgs pkgs/atom

  if dpkg --get-selections | grep -q "^atom[[:space:]]*install$" >/dev/null; then
    echo ""
  else
    # Check the exit status of the install
    echo -e "\e[36mInstalling Atom packages\e[0m"
    apm install atom-ide-ui ide-r ide-python ide-rust atom-language-r language-liquid hydrogen hydrogen-launcher gpp-compiler minimap pigments platformio-ide-terminal atom-material-ui atom-material-syntax file-icons project-manager
  fi
}

#-------------------------------------------------------------------------------
# Install Insync and Dropbox
#-------------------------------------------------------------------------------
install_cloud_storage() {
  if grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep insync; then
    echo -e "\e[36mAlready added to sources.list\e[0m"
  else
    # Insync key
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys ACCAF35C
    touch /etc/apt/sources.list.d/insync.list
    echo "deb http://apt.insync.io/ubuntu eoan non-free contrib" | tee -a /etc/apt/sources.list.d/insync.list
    apt-get update
  fi

  install_pkgs pkgs/cloud-storage
}

#-------------------------------------------------------------------------------
# Install other software
#-------------------------------------------------------------------------------
install_other() {
  # Check OBS
  if grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep obs; then
    echo -e "\e[36mAlready added to sources.list\e[0m"
  else
    add-apt-repository ppa:obsproject/obs-studio
    apt-get update
  fi

  # Check Spotify
  if grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep spotify; then
    echo -e "\e[36mAlready added to sources.list\e[0m"
  else
    # Spotify key
    curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    apt-get update
  fi

  install_pkgs pkgs/other
}

#-------------------------------------------------------------------------------
# Change system wide settings
#-------------------------------------------------------------------------------
change_settings() {
  # Swappiness
  echo "vm.swappiness=10" | tee -a /etc/sysctl.conf
}

#-------------------------------------------------------------------------------
# Set up folders
#-------------------------------------------------------------------------------
setup_folders() {
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
}

#-------------------------------------------------------------------------------
# Copy and set up dotfiles
#-------------------------------------------------------------------------------
setup_dotfiles() {
   git clone https://github.com/edsandorf/.dotfiles.git ~/.dotfiles

   #  Create symlinks
   ln -s ~/.dotfiles/.bashrc ~/.bashrc
   ln -s ~/.dotfiles/.conkyrc ~/.conkyrc
   ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
   ln -s ~/.dotfiles/texstudio.ini ~/.config/texstudio.ini

   #  Add conky to startup

}

#-------------------------------------------------------------------------------
# Define the whiptail user interface - main function
#-------------------------------------------------------------------------------
menu_list() {
  OPTION=$(\
    whiptail\
    --title "System setup 0.0.1"\
    --menu "What do you want to do?"\
    30 78 20\
    "1" "Update package list and upgrade system"\
    "2" "Install utilities"\
    "3" "Install Gnome and Gnome specific extras"\
    "4" "Install Ubuntu extras"\
    "5" "Install OpenBLAS, R and RStudio"\
    "6" "Install Julia"\
    "7" "Install Ruby and bundler"\
    "8" "Install Anaconda Python"\
    "9" "Install TeXLive and TeXStudio"\
    "10" "Install Atom"\
    "11" "Install Cloud Storage Solutions"\
    "12" "Install other software (deluge, spotify, vlc, gimp, virtualbox ...)"\
    "13" "Set systemwide settings"\
    "14" "Set up folder structure"\
    "15" "Download and copy dotfiles"\
    "16" "Reboot"\
    3>&1 1>&2 2>&3\
  )

  # Define what happens when an option is chosen
  case $OPTION in
    1) echo -e "\e[36mUpdating package list and upgrading the system\e[0m"
       do_update_and_upgrade | whiptail --title "Updating and upgrading packages" --gauge "" 6 60 0
       ./install-and-setup-utility.sh;;
    2) echo -e "\e[36mInstalling utilities\e[0m"
       install_pkgs pkgs/utilities
       ./install-and-setup-utility.sh;;
    3) echo -e "\e[36mInstalling Gnome and Gnome extras\e[0m"
       install_pkgs pkgs/gnome-extras
       ./install-and-setup-utility.sh;;
    4) echo -e "\e[36mInstalling Ubuntu extras\e[0m"
       install_pkgs pkgs/ubuntu-extras
       ./install-and-setup-utility.sh;;
    5) echo -e "\e[36mInstalling OpenBLAS, R and RStudio\e[0m"
       install_r
       ./install-and-setup-utility.sh;;
    6) echo -e "\e[36mInstalling Julia\e[0m"
       install_julia
       ./install-and-setup-utility.sh;;
    7) echo -e "\e[36mInstalling Ruby\e[0m"
       install_ruby
       ./install-and-setup-utility.sh;;
    8) echo -e "\e[36mInstalling Anaconda Python\e[0m"
       install_python
       ./install-and-setup-utility.sh;;
    9) echo -e "\e[36mInstalling TeXLive and TeXStudio\e[0m"
       install_tex
       ./install-and-setup-utility.sh;;
    10) echo -e "\e[36mInstalling Atom\e[0m"
       install_atom
       ./install-and-setup-utility.sh;;
    11) echo -e "\e[36mInstalling cloud storage solution\e[0m"
        install_cloud_storage
        ./install-and-setup-utility.sh;;
    12) echo -e "\e[36mInstalling other software[0m"
        install_other
        ./install-and-setup-utility.sh;;
    13) echo -e "\e[36mSetting systemwide settings[0m"
        change_settings
        ./install-and-setup-utility.sh;;
    14) echo -e "\e[36Setting up folders[0m"
        setup_folders
        ./install-and-setup-utility.sh;;
    15) echo -e "\e[36mCopying and setting up dotfiles[0m"
        setup_dotfiles
        ./install-and-setup-utility.sh;;
    16) systemctl reboot;;
  esac
}

menu_list
