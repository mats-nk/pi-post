#!/bin/bash
# (c) Mats Karlsson 2024-01-10

# Features
# --------
# - Adds packages I want to have
# - Adds neofetch and update it and adds a custom config
# - Modify motd so neofetch is used
# - Adds two scripts to create a cache funtionality to decrease the time delay the wweather and apt features would take.
#   - Adds two entries to crontab
# - Adds closer NTP sources
# - Disable swap

# ToDo:
# -----
# - Add Avahi/mDNS services
# - Add Samba
# - Add Power off button
# - Change logging behaviour
# - Menu for "NTP" country??? or $1 arg?

# Check if root
if [ "$EUID" -ne 0 ]
  then echo "No sudo, nice!"
  else (echo "Don't use sudo! Restart the script without sudo.")
  exit
fi

# Variables
NOW=`date '+%Y-%M-%d'`

# Update
sudo apt update
sudo apt --yes upgrade

# Install apps
echo "--------------------"
echo "--- Install apps ---"
echo "--------------------"

apps_to_be_installed="
ntp
git
mc
build-essential
avahi-utils
curl
wget
jq
bc
tree
python3-pip
figlet
cowsay
fortune
neofetch
dnsutils
iputils-tracepath
traceroute
ngrep
mtr
tcptraceroute
lshw
sshfs
dialog"
# Removed: tshark

sudo apt install --yes $apps_to_be_installed

# neofetch as Message Of The Day (motd)
# Upgrade neofetch from 7.1 (installed by apt) to 7.2.8 (LanikSJ version)
wget https://raw.githubusercontent.com/LanikSJ/neofetch/master/neofetch
chmod +x neofetch
sudo chown root:root /usr/bin/neofetch
sudo mv neofetch /usr/bin/neofetch
sudo mv /etc/motd /etc/motd.org

sudo bash -c 'cat << 'EOF' > /etc/profile.d/neofetch.sh
export TEXTDOMAIN=Linux-PAM
. gettext.sh
echo ""
neofetch
EOF'

# neofetch config
FILE=/home/$USER/.config/neofetch/config.conf
if test -f "$FILE"
then
  echo "$FILE exists."
else
  mkdir -p /home/$USER/.config/neofetch
  wget https://raw.githubusercontent.com/mats-nk/pi-post/main/templates/config.conf -O /home/$USER/.config/neofetch/config.conf
fi

# Disable PrintLastLog
sudo bash -c 'cat << 'EOF' > /etc/ssh/sshd_config.d/printlastlog.conf
# mk 2024-01-10
PrintLastLog no
EOF'

# Cache script run by crontab
sudo wget https://raw.githubusercontent.com/mats-nk/pi-post/main/scripts/apt_info -O /usr/local/bin/apt_info
sudo wget https://raw.githubusercontent.com/mats-nk/pi-post/main/scripts/weather -O /usr/local/bin/weather
sudo chmod +x /usr/local/bin/apt_info
sudo chmod +x /usr/local/bin/weather

# Add crontab entries
## Get the crontab template
sudo wget https://raw.githubusercontent.com/mats-nk/pi-post/main/templates/crontab.tmpl -O ~/.config/crontab.tmpl

## Create a new temporary crontab and add the crontab template to the as a header
cat ~/.config/crontab.tmpl > ~/.config/mycrontab

## Add the current crontab to the temporary crontab and remove all comments
crontab -l | sudo sed -E 's/#.*$//;/^$/d' >> ~/.config/mycrontab

## Add new crontab tasks to the temporary crontab
echo "  *     */2   *     *     *     /usr/local/bin/weather Stockholm" >> ~/.config/mycrontab
echo "  */28  *     *     *     *     /usr/local/bin/apt_info" >> ~/.config/mycrontab
echo "@reboot                         /usr/local/bin/weather Stockholm" >> ~/.config/mycrontab
echo "@reboot                         /usr/local/bin/apt_info" >> ~/.config/mycrontab

## Activate the temporary crontab as the current crontab
crontab ~/.config/mycrontab

# Disable swap
sudo dphys-swapfile swapoff && \
sudo dphys-swapfile uninstall && \
sudo systemctl disable dphys-swapfile

# Avahi/mDNS
# Change to "workstation=yes"
# Add services ssh.service

# NTP - Assure that it fetching current time from internet
# Replace defaults in ntp.conf with Swedish NTP pool
## Bullseye uses /etc/ntp.conf
## Bookworm uses /etc/ntpsec/ntp.conf
#
version=$(awk -F "=" '/VERSION_CODENAME/ {print $2}' /etc/os-release)
if [ $version = bullseye ]
then
  sudo sed -i 's/0.debian.pool.ntp.org/0.se.pool.ntp.org/g' /etc/ntp.conf
  sudo sed -i 's/1.debian.pool.ntp.org/1.se.pool.ntp.org/g' /etc/ntp.conf
  sudo sed -i 's/2.debian.pool.ntp.org/2.se.pool.ntp.org/g' /etc/ntp.conf
  sudo sed -i 's/3.debian.pool.ntp.org/3.se.pool.ntp.org/g' /etc/ntp.conf
elif [ $version = bookworm ]
then
  sudo sed -i 's/0.debian.pool.ntp.org/0.se.pool.ntp.org/g' /etc/ntpsec/ntp.conf
  sudo sed -i 's/1.debian.pool.ntp.org/1.se.pool.ntp.org/g' /etc/ntpsec/ntp.conf
  sudo sed -i 's/2.debian.pool.ntp.org/2.se.pool.ntp.org/g' /etc/ntpsec/ntp.conf
  sudo sed -i 's/3.debian.pool.ntp.org/3.se.pool.ntp.org/g' /etc/ntpsec/ntp.conf
fi

# Power button
# Add power On/Off button to /boot/config.txt


# Logging
# log2ram
#

clean-up () {
   # Clean up everything
   echo "Cleaning Up" &&
   apt -y autoremove &&
}

sudo clean-up
