#!/bin/bash
if [[ -e *.log ]]; then
  rm *.log
fi
docker exec -t openfire-docker-compose_xmpp1_1 cat /usr/local/openfire/logs/all.log > 1.log
docker exec -t openfire-docker-compose_xmpp2_1 cat /usr/local/openfire/logs/all.log > 2.log
docker exec -t openfire-docker-compose_xmpp3_1 cat /usr/local/openfire/logs/all.log > 3.log
