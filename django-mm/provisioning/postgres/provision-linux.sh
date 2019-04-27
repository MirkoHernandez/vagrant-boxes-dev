#!/usr/bin/env bash

POSTGRES_VERSION=$1


sudo apt-get update
sudo apt-get install  -y tmux

# Install postgres
echo "Installing PostgreSQL"
sudo apt-get install  -y postgresql-$POSTGRES_VERSION postgresql-contrib-$POSTGRES_VERSION

# tmux config
touch ~vagrant/.tmux.conf
printf "set -g base-index 1\n" >> ~vagrant/.tmux.conf

# Aliases
touch ~vagrant/.bash_aliases
