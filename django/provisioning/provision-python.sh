#!/usr/bin/env bash

PYTHON_VERSION=$1

# Install python
sudo apt-get install python$PYTHON_VERSION python$PYTHON_VERSION-dev 

# Install pip3
wget -q https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py

# Install virtualenv virtualenvwrapper
sudo pip install --quiet virtualenv  virtualenvwrapper

# Set Virtualenvwrapper settings in .bashrc
printf "\n\n# Virtualenv settings\n" >> ~vagrant/.bashrc
printf "export WORKON_HOME=~vagrant/.virtualenvs\n" >> ~vagrant/.bashrc
printf "export PROJECT_HOME=/vagrant\n" >> ~vagrant/.bashrc
printf "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3\n" >> ~vagrant/.bashrc
printf "export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv\n" >> ~vagrant/.bashrc
printf "source /usr/local/bin/virtualenvwrapper.sh\n" >> ~vagrant/.bashrc

# Create virtualenvs folder
mkdir -p ~vagrant/.virtualenvs
