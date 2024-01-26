# pi-post

`pi-post.sh` is a script that will install my programs and tweak the OS into my desires.

After you have created a new installation of Raspbery Pi OS and logged in to it with SSH.

### Run
```bash
wget https://raw.githubusercontent.com/mats-nk/pi-post/main/pi-post.sh
chmod +x pi-post.sh
./pi-post.sh
```

### Added features
- Adds packages I want to have
- Adds neofetch and update it and adds a custom config
- Modify motd so neofetch is used
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

