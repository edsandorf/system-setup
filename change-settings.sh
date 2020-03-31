#!/bin/bash
#
# Description:
#   Changes some global settings for the system
#
# Author:
#   Erlend Dancke Sandorf <edsandorf [:at:] gmail.com>
#
# Sources:
#   https://pat-s.me/post/arch-install-guide-for-r/

# Change the shell to fish shell
sudo chsh -s `which fish` edsandorf

# Enable trim for optimizing SSD performance
sudo systemctl enable fstrim.timer

# Change the swappiness of the system
sudo echo "vm.swappiness=10" > /etc/sysctl.d/100-manjaro.conf
sudo sysctl --system
