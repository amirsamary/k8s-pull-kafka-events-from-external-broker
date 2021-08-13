#!/bin/bash

source ./utils.sh

K3S_IMAGE="docker.io/rancher/k3s:v1.19.5-k3s1"

trace "Cleaning up..."
docker-compose down
docker-compose rm -f
k3d cluster delete k3s-default
docker network prune -f

trace "Creating k3d cluster..."
k3d cluster create --agents 1 --network k3d-net -i $K3S_IMAGE --no-hostip
exit_if_error "Could not create k3d cluster."

trace "Starting docker-compose attached to k3d cluster's network..."
docker-compose up -d
exit_if_error "Could not start docker-compose."

warn "Wait for docker-compose to stabilize before running the next script."