#!/bin/bash

source ./.env
source ./utils.sh

trace "Trying to pull events from the kafka broker running in docker compose using the kafka tools of the kafka broker running in Kubernetes. Press CTRL+C to stop pulling."
kubectl exec -it kafka-tools -c kafka1 -- kafka-console-consumer --bootstrap-server kafka-service:9093 --topic foo --from-beginning
