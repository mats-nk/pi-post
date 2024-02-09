# pi-post

The prime reason for `pi-post` was created on the need to get personal modifications and tweaks.

The second reason for `pi-post` is to corret issues that the "Raspberry Pi OS maintainers" refuse even when it's wrong, instead of fixing issues they are more prone to use resources on shooting down issues than to fix them. This bad attitude from the Raspberry Pi OS maintainers is just reflecting bad on the wonderfull Raspberry Pi.

Ref.: https://github.com/raspberrypi/bookworm-feedback/issues/204

<img src="https://github.com/mats-nk/pi-post/blob/main/images/neofetch.gif" width="300">

`pi-post.sh` installs my programs, addons and tweak the OS into my desires.

After you have created a new installation of Raspbery Pi OS and logged in to it with SSH.

### Run
```bash
wget https://raw.githubusercontent.com/mats-nk/pi-post/main/pi-post.sh
chmod +x pi-post.sh
./pi-post.sh
```

### Added features
- Adds packages I want to have
- Install neofetch, update it to 7.2.8 and adds a custom config
- Modify motd so neofetch is used when logging in to the system
- Adds two scripts to create a cache funtionality to decrease the time delay the wweather and apt features would take.
  - adds two entries to crontab
- Adds NTP sources that is close
- Disable swap


### The script will install the following packages
| Program           | Description                            | URL |
| ---               | ---                                    | --- |
| lynx              | Commandline based web browser          |     |
| mc                | Midnight commander                     |     |
| neofetch          | A command-line system information tool |     |
| ntp               | Network Time Protocol. Keep the time   |     |
| git               |                                        |     |
| avahi-utils       |                                        |     |
| dnsutils          |                                        |     |
| python3-pip       |                                        |     |
| curl              |                                        |     |
| iputils-tracepath |                                        |     |
| traceroute        |                                        |     |
| wget              |                                        |     |
| build-essential   |                                        |     |
| jq                |                                        |     |
| bc                |                                        |     |
| tree              |                                        |     |
| figlet            |                                        |     |
| cowsay            |                                        |     |
| fortune           |                                        |     |
| sshfs             |                                        |     |
| ngrep             |                                        |     |
| mtr               |                                        |     |
| tcptraceroute     |                                        |     |

### And modify 
- motd 
Adds a banner when logging in. Its based on neofetch.

