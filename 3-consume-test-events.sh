#!/bin/bash
 
source ./.env
source ./utils.sh

trace "Connecting from local machine where kafka broker is running as docker container. At the end, CTRL+C to stop pulling."
docker-compose exec broker  \
kafka-console-consumer --bootstrap-server localhost:29092 --topic foo --from-beginning