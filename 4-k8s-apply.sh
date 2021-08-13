#!/bin/bash

source ./.env
source ./utils.sh

trace "Obtainging IP of broker running in docker-compose..."
export KAFKA_BROKER_IP=$(docker inspect broker | perl -n -e'/^ *"IPAddress": *"([0-9][0-9.]+)",/ && print $1')

trace "IP of broker in k3d-net is: $KAFKA_BROKER_IP"

trace "Creating Endpoint in k8s for IP $KAFKA_BROKER_IP..."
cat <<EOF | kubectl apply -f -
kind: Endpoints
apiVersion: v1
metadata:
  name: kafka-service
subsets:
  - addresses:
      - ip: ${KAFKA_BROKER_IP}
    ports:
      - port: 9093
EOF
exit_if_error "Could not create Endpoint."

trace "Creating cluster IP service for endpoint..."
kubectl apply -f ./kafka-service.yaml
exit_if_error "Could not Cluster IP Service for Endpoint."

trace "Starting another kafka broker in Kubernetes so we can use kafka tools (this broker will not be used at all):"
kubectl apply -f ./kafka-tools.yaml
exit_if_error "Could not create Kafka broker"

warn "Wait for the deployments to stabilize before. Running the next script."