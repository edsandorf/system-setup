# system-setup
A collection of scripts used to set up my system on a fresh install


## the install-and-setup-utility-ubuntu.sh
Run as root (sudo). Make all shell scripts executable first, e.g. `chmod +x install-and-setup-utility.sh`.

NOTE! This will be changed. Running as 'sudo' does mean that we cannot create the symlinks to the folders since we don't have write access.

The script uses the bash scripts in the root folder and pulls package lists from `.txt`-files in the `txt`-folder.
