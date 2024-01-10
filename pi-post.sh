#!/bin/bash
# (c) Mats Karlsson
# 2024-01-10

# Check if root
if [ "$EUID" -ne 0 ]
  then echo "Please use sudo"
  exit
  else (echo "sudo is used")
fi

# Update
apt update
apt --yes upgrade


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

apt install --yes $apps_to_be_installed


# motd and neofetch upgrade from 7.1 to 7.2.8
wget https://raw.githubusercontent.com/LanikSJ/neofetch/master/neofetch
chmod +x neofetch
chown root:root /usr/bin/neofetch
mv neofetch /usr/bin/neofetch

mv /etc/motd /etc/motd.org

cat << 'EOF' > /etc/profile.d/neofetch.sh
# neofetch as Message Of The Day (motd)
export TEXTDOMAIN=Linux-PAM
. gettext.sh
EOF

cat << 'EOF' > /etc/ssh/sshd_config`.d/printlastlog.conf
PrintLastLog no
EOF

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
