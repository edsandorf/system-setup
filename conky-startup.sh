#!/bin/bash
#
# Set to sleep for a short duration to allow desktop startup
#
# Make executable: chmod +x conky-startup.sh
# copy conky-startup.desktop -> .config/autostart/ and make it executable
sleep 10
conky -b &
