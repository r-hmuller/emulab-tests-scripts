#!/bin/bash

apt update
apt upgrade -y
apt-get install ca-certificates curl gnupg lsb-release snapd -y
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" |  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin apache2-utils -y
snap install microk8s --classic
microk8s status --wait-ready
chmod +x make-registry-available.sh
. make-registry-available.sh

cd registry
docker-composer up -d docker-compose.yaml

cd ..
