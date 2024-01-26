#!/bin/bash
# (c) Mats Karlsson
# 2024-01-10

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
lshw"
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
EOF'

# neofetch config
FILE=/home/$USER/.config/neofetch/config.conf
if test -f "$FILE"
then
  echo "$FILE exists."
else
  mkdir -p /home/$USER/.config/neofetch
  wget https://raw.githubusercontent.com/mats-nk/pi-post/main/config.conf -O /home/$USER/.config/neofetch/config.conf
fi

# Cache script run by crontab
sudo wget https://raw.githubusercontent.com/mats-nk/pi-post/main/apt_info -O /usr/local/bin/apt_info
sudo wget https://raw.githubusercontent.com/mats-nk/pi-post/main/weather -O /usr/local/bin/weather
sudo chmod +x /usr/local/bin/apt_info
sudo chmod +x /usr/local/bin/weather

# Disable PrintLastLog
sudo bash -c 'cat << 'EOF' > /etc/ssh/sshd_config.d/printlastlog.conf
# mk 2024-01-10
PrintLastLog no
EOF'

# Disable swap
sudo dphys-swapfile swapoff && \
sudo dphys-swapfile uninstall && \
sudo systemctl disable dphys-swapfile

# Avahi/mDNS
# Change to "workstation=yes"
# Add services ssh.service

# NTP - Always have to correct time
# sed /etc/ntpsec/ntp.conf
# Default from install
#pool 0.debian.pool.ntp.org iburst
#pool 1.debian.pool.ntp.org iburst
#pool 2.debian.pool.ntp.org iburst
#pool 3.debian.pool.ntp.org iburst

# Replce with se.pool.ntp.org
#pool 0.se.pool.ntp.org iburst
#pool 1.se.pool.ntp.org iburst
#pool 2.se.pool.ntp.org iburst
#pool 3.se.pool.ntp.org iburst


# Power button
# Add power On/Off button to /boot/config.txt


# Logging


clean-up () {
   # Clean up everything
   echo "Cleaning Up" &&
   apt -f install &&
   apt -y autoremove &&
   apt -y autoclean &&
   apt -y clean
}
