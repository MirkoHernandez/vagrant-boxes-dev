#!/usr/bin/env bash

POSTGRES_VERSION=$1

touch ~vagrant/.bash_aliases

sudo apt-get update
sudo apt-get install  -y git tmux

# Install postgres
sudo apt-get install  -y postgresql-$POSTGRES_VERSION postgresql-contrib-$POSTGRES_VERSION
