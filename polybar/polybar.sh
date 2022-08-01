#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

#polybar -c ~/git/mine/dotfiles/polybar/config.ini base 2>&1 \
#    | tee -a /tmp/polybar.log & disown

polybar -c ~/git/mine/dotfiles/polybar/config.ini base > /dev/null & disown

echo "Polybar launched..."
