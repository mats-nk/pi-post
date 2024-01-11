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
tshark
ngrep
mtr
tcptraceroute"

sudo apt install --yes $apps_to_be_installed

# neofetch as Message Of The Day (motd)
# motd and neofetch upgrade from 7.1 to 7.2.8
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

# Disable PrintLastLog
sudo bash -c 'cat << 'EOF' > /etc/ssh/sshd_config.d/printlastlog.conf
# mk 2024-01-10
PrintLastLog no
EOF'

# Check if neofetch config file exists. If not download it
FILE=~/.config/neofetch/config.conf
if test -f "$FILE"; then
    echo "$FILE exists."
    else (echo "$FILE doesn't exists.")
fi


# Disable swap
dphys-swapfile swapoff && \
dphys-swapfile uninstall && \
systemctl disable dphys-swapfile


# Avahi/mDNS


# NTP
# sed /etc/ntpsec/ntp.conf
# Default
#pool 0.debian.pool.ntp.org iburst
#pool 1.debian.pool.ntp.org iburst
#pool 2.debian.pool.ntp.org iburst
#pool 3.debian.pool.ntp.org iburst


# se.pool.ntp.org
#pool 0.se.pool.ntp.org iburst
#pool 1.se.pool.ntp.org iburst
#pool 2.se.pool.ntp.org iburst
#pool 3.se.pool.ntp.org iburst


# Power button


# Logging


clean-up () {
   # Clean up everything
   echo "Cleaning Up" &&
   apt -f install &&
   apt -y autoremove &&
   apt -y autoclean &&
   apt -y clean
}
