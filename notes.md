## Check if neofetch is updated

`curl -s https:/api.github.com/repos/LanikSJ/neofetch/tags | jq -r 'first(.[].name | select(test("^v?[0-9]")))'`

# ToDo

### weather

Store cached weather for 2 hours in /home/$USER/.config/weather.txt

```#!/bin/bash
curl -s wttr.in/SomeCity?0?q?T | awk '/°(C|F)/ {printf $(NF-1) $(NF)}' > /home/$USER/.config/weather.txt
```
Remember city (arg1)

`curl -s wttr.in/$1?0?q?T | awk '/°(C|F)/ {printf $(NF-1) $(NF)}' > /home/$USER/.config/weather.txt`

