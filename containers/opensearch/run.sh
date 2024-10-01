#!/bin/bash

export OPENSEARCH_INITIAL_ADMIN_PASSWORD=strongPassword123!

if [ "$(docker ps -a -q -f name=opensearch-node1)" ]; then
    echo 'containers already exist. Starting...'
    docker compose start;
else
    echo 'containers do not exist. Creating...'
    docker compose up -d
fi

echo 'waiting for containers to start...'
sleep 20

echo opensearch available at https://localhost:9200
echo dashboard available at https://localhost:5601
echo login with admin:$OPENSEARCH_INITIAL_ADMIN_PASSWORD

start http://localhost:9200
start http://localhost:5601



