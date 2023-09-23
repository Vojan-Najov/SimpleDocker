#!/bin/bash

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable docker.service
sudo systemctl enable containerd.service

if [ -z "$(groups | grep docker)" ]; then
  sudo groupadd docker
  sudo usermod -aG docker "$USER"
  newgrp docker
fi

sudo apt install make
sudo apt install openbox
sudo apt install xinit 
sudo apt install kitty firefox-esr
sudo apt install firefox
sudo apt install gcc
sudo apt install libfcgi-dev
sudo apt install spawn-fcgi
sudo apt install nginx
sudo systemctl stop nginx.service
sudo systemctl disable nginx.service
sudo apt install docker-compose

VERSION=$(
 curl --silent "https://api.github.com/repos/goodwithtech/dockle/releases/latest" | \
	  grep '"tag_name":' | \
	   sed -E 's/.*"v([^"]+)".*/\1/' \
   ) && curl -L -o dockle.deb https://github.com/goodwithtech/dockle/releases/download/v${VERSION}/dockle_${VERSION}_Linux-64bit.deb
sudo dpkg -i dockle.deb && rm dockle.deb

