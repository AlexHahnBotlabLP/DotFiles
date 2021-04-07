#!/bin/sh

#----------------------------------------------------------------
# create symbolic link files for all files in ~/.dotfiles/
#----------------------------------------------------------------

ln -s ~/.dotfiles/bash_aliases ~/.bash_aliases
ln -s ~/.dotfiles/bashrc ~/.bashrc
ln -s ~/.dotfiles/create-home-desktop-tmux.sh ~/create-home-desktop-tmux.sh
ln -s ~/.dotfiles/emacs.d ~/.emacs.d
ln -s ~/.dotfiles/ghci ~/.ghci
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/vim  ~/.vim
ln -s ~/.dotfiles/vimrc ~/.vimrc
ln -s ~/.dotfiles/workDesktopTmuxStartUpScript.sh ~/workDesktopTmuxStartUpScript.sh
