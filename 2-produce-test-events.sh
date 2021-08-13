#!/bin/bash

source ./.env
source ./utils.sh
 
trace "Connecting from local machine where kafka broker is running as docker container."
docker-compose exec broker  \
    bash -c "seq 10 | kafka-console-producer --request-required-acks 1 --broker-list localhost:29092 --topic foo && echo 'Produced 10 messages.'"
