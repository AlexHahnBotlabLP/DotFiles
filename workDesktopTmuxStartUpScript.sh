#!/bin/sh

#----------------------------------------------------
# Tmux script to get work desktop set up
#----------------------------------------------------

bllpDirectory= $("repos/bllp-platform")


#----------------------------------------------------
# bllp-platform development session
#----------------------------------------------------
tmux new -d -s 'BllpDev'
tmux send-keys 'cd ~/repos/bllp-platform' Enter # C-m is the same as Enter
# TODO: can partition windows with tmux specific commands to make even splits/ panes set up exactly

tmux split-window -h
# MIDDLE PANE
# TODO: make directory structure same as home desktop and laptop
tmux send-keys 'cd ~/repos/bllp-platform' Enter
tmux send-keys 'nix-shell --run ghcid' Enter
# RIGHT PANE
tmux split-window -h
tmux send-keys 'cd ~/repos/bllp-platform' Enter

#----------------------------------------------------
# Run Trading and PM  Websites
#----------------------------------------------------

# Trading website commands
tmux new -d -s 'RunWebsites'
tmux send-keys 'cd repos/trading-website' Enter
tmux send-keys 'git pull' Enter
tmux send-keys 'TRADING_IP=4001 nix-shell --run trading-runner' Enter

tmux split-window -v
tmux send-keys 'cd repos/trading-website' Enter
tmux send-keys 'TRADING_IP=4001 nix-shell --run trading-runner ghcjs.nix' Enter

# select top pane
tmux select-pane -t 0

# PM website commands
tmux split-window -h
tmux send-keys 'cd repos/pm-website' Enter
tmux send-keys 'git pull' Enter
tmux send-keys 'nix-shell --run pm-runner' Enter

# select bottom pane
tmux select-pane -t 2

tmux split-window -h
tmux send-keys 'cd repos/pm-website' Enter
tmux send-keys 'nix-shell --run pm-runner ghcjs.nix' Enter


# If local network connection is slow, sometimes you can leverage the cloud tunnel running the sites/ doing a lot of the lifting

# tmux send-keys 'ssh -L 4000:localhost:4000 ubuntu@tun.botlablp.com -NT' Enter # pm
# tmux split-window -h
# tmux send-keys 'ssh -L 4001:localhost:4001 ubuntu@tun.botlablp.com -NT' Enter # trading

#----------------------------------------------------
# open Trading and PM  Websites (maybe add all startup websites?)
#----------------------------------------------------
tmux new -d -s 'OpenWebsites'
tmux send-keys 'google-chrome http://localhost:4001 http://localhost:4000' Enter

#----------------------------------------------------
# Trading (on Desktop on Schonfeld Network)
#---------------------------------------------------
tmux new -d -s 'Trading'
today=$(date +'%Y%m%d')

# TOP PANE
tmux send-keys 'nixops ssh oms' Enter
tmux send-keys 'cd PROD_TRADING' Enter

tmux split-window -v

#TODO: check mount status and mount if needed (or just umount and remount each time?)
# BOTTOM PANE
# maybe check mnt status and mount/ unmount first?
tmux send-keys 'cd /mnt/prod_oms/'"$today" Enter
tmux send-keys 'tail -f input.json | jq' Enter

tmux split-window -h
tmux send-keys 'cd /mnt/prod_oms/'"$today" Enter
tmux send-keys 'tail -f output.json | jq' Enter

tmux split-window -h
tmux send-keys 'cd /mnt/prod_oms/'"$today" Enter
tmux send-keys 'tail -f status.json | jq' Enter

#----------------------------------------------------
# Iris (on Desktop on Schonfeld Network)
#----------------------------------------------------
tmux new -d -s 'Iris'

tmux send-keys 'JAVA_EXE=/home/alexhahn/Downloads/jdk1.8.0_211/bin/java ~/DeephavenLauncher/DeephavenLauncher.sh' Enter

#----------------------------------------------------
# Emacs daemon (may want to put all backround processes in one session to avoid clutter)
#----------------------------------------------------
tmux new -d -s 'Emacs'
tmux send-keys 'emacs --daemon' Enter
#tmux send-keys 'emacsclient -t' Enter #Can't run this inside of tmux or it opens emacs inside of it (despite the -t) ToDo: look into how to open a new terminal/emacs window

tmux attach-session -t Trading


