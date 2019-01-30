#!/usr/bin/env bash

sudo apt-get install -y curl

# Install node
curl -sL https://deb.nodesource.com/setup_11.x | sudo bash -
printf "alias node='nodejs'\n" >> ~vagrant/.bashrc


# Install yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list


# Install yeoman
sudo npm install -g yo

sudo apt-get update

# Install ruby
sudo apt-get install -y nodejs yarn ruby ruby-dev

# Install hologram
sudo gem install hologram





