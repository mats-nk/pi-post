## Check if neofetch is updated

`curl -s https:/api.github.com/repos/LanikSJ/neofetch/tags | jq -r 'first(.[].name | select(test("^v?[0-9]")))'`

# ToDo

### Change default WiFi connection name in "Network Manager"

Changes from the nondescriptive name "Preconfigured" to "MyWiFi"

`sudo nmcli connection modify preconfigured connection.id MyWiFi`

Verify with `nmcli connection show`

### weather

Store cached weather for 2 hours in /home/$USER/.config/weather.txt

```#!/bin/bash
curl -s wttr.in/<SomeCity>?0?q?T | awk '/°(C|F)/ {printf $(NF-1) $(NF)}' > /home/$USER/.config/weather.txt
```
Remember city (arg1)

`curl -s wttr.in/$1?0?q?T | awk '/°(C|F)/ {printf $(NF-1) $(NF)}' > /home/$USER/.config/weather.txt`

## Screen recording and animated GIFs

Install `sudo apt install asciinema`

run: `asciinema rec youterminal.cast`

Push ctrl + D to stop recording and type `exit` to exit asciinema.

Convert the "asciinema" recording file to an animated gif, https://dstein64.github.io/gifcast/
