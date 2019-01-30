#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y git tmux



# tmux config
touch ~vagrant/.tmux.conf
printf "set -g base-index 1\n" >> ~vagrant/.tmux.conf

# Aliases
touch ~vagrant/.bash_aliases


