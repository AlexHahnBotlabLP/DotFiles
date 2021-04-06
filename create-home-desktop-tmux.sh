#!/bin/sh
#----------------------------------------------------
# bllp-platform development session
#----------------------------------------------------
tmux new -d -s 'BllpDev'
#TODO: can partition windows with tmux specific commands to make even splits/ panes set up exactly
tmux split-window -h
#MIDDLE PANE
tmux send-keys 'cd ~/Botlab/CodeBase/bllp-platform' C-m
tmux send-keys 'nix-shell --run ghcid' C-m
tmux split-window -h

#----------------------------------------------------
# Trading (on Desktop on Schonfeld Network)
#----------------------------------------------------
tmux new -d -s 'Trading'
tmux send-keys 'ssh -tYC ubuntu@tun.botlablp.com robust_remote_connect/cloud/connect_from_cloud.sh alexhahn BLab' C-m
tmux send-keys 'tmux attach-session -t trading' C-m

#----------------------------------------------------
# Iris (on Desktop on Schonfeld Network)
#----------------------------------------------------
tmux new -d -s 'Iris'
tmux send-keys 'ssh -tYC ubuntu@tun.botlablp.com robust_remote_connect/cloud/connect_from_cloud.sh alexhahn BLab' C-m
tmux send-keys 'JAVA_EXE=/home/alexhahn/Downloads/jdk1.8.0_211/bin/java ~/DeephavenLauncher/DeephavenLauncher.sh' C-m

#----------------------------------------------------
# Run Trading Website
#----------------------------------------------------
#TODO: Currently this runs on work desktop and forwards to native machine, once on a decent network change this to run purely natively
tmux new -d -s 'TradingWebsiteProxy'
tmux send-keys 'ssh -L 4001:localhost:4001 ubuntu@tun.botlablp.com -NTC' C-m
#tmux send-keys 'firefox localhost:4001' C-m
#tmux send-keys 'ssh -tY ubuntu@tun.botlablp.com robust_remote_connect/cloud/connect_from_cloud.sh alexhahn BLab' C-m
#tmux send-keys 'firefox localhost:4001' C-m

#----------------------------------------------------
# Run PM Website
#----------------------------------------------------
#TODO: Currently this runs on work desktop and forwards to native machine, once on a decent network change this to run purely natively
tmux new -d -s 'PMWebsiteProxy'
tmux send-keys 'ssh -L 4000:localhost:4000 ubuntu@tun.botlablp.com -NTC' C-m
#tmux send-keys 'firefox localhost:4001' C-m


#----------------------------------------------------
# Run Firefox websites
#----------------------------------------------------
tmux new -d -s 'Open Firefox Websites'
tmux send-keys 'sleep 4s' C-m
tmux send-keys 'firefox -new-tab -url localhost:4000 -new-tab -url localhost:4001' C-m

#----------------------------------------------------
# Work Desktop (non TMUX attaced)
#----------------------------------------------------
tmux new -d -s 'WorkDesktop'
tmux send-keys 'ssh -tYC ubuntu@tun.botlablp.com robust_remote_connect/cloud/connect_from_cloud.sh alexhahn BLab' C-m


#tmux attach-session -t BllpDev

tmux attach-session
