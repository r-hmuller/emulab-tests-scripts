#!/bin/bash

OPERATOR_PATH = "/users/Hmuller/cr-operator"
REGISTRY_URL = "http://10.10.1.2:5000"

apt update
apt upgrade -y
apt install snapd build-essential make git -y
snap install microk8s --classic
microk8s status --wait-ready
chmod +x make-registry-available.sh
. make-registry-available.sh

microk8s stop
microk8s start

if [ ! -d $OPERATOR_PATH ] 
then
    git clone https://github.com/r-hmuller/cr-operator
fi

cd $OPERATOR_PATH
make install
kctl apply -f config/samples/
make docker-build docker-push IMG=$REGISTRY_URL/cr-operator:0.0.1
make deploy IMG=$REGISTRY_URL/cr-operator:0.0.1

#https://docs.delltechnologies.com/bundle/P_DG_CL_71/page/GUID-78189948-0D39-4C51-9C0B-DEC254146570.html

microk8s add-node