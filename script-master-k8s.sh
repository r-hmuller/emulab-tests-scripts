#!/bin/bash

apt update
apt upgrade -y
apt install snapd -y
snap install microk8s --classic
microk8s status --wait-ready