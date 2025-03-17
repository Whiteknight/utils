#!/bin/bash

docker compose up -d

echo "management console: http://localhost:15672 login with guest/guest"
echo "AMQP: localhost:5672"