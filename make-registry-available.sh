#!/bin/bash

mkdir -p /var/snap/microk8s/current/args/certs.d/10.10.1.2:5000
cp hosts.toml /var/snap/microk8s/current/args/certs.d/10.10.1.2:5000/hosts.toml

sleep(2)
microk8s stop
microk8s start
