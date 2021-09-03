#!/bin/sh
if [ -n "$1" ]; then
  docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba netem --target 172.60.0.20 --target 172.60.0.30 --duration $1 loss --percent 100 openfire-docker-compose_xmpp1_1
else
  docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba netem --target 172.60.0.20 --target 172.60.0.30 --duration 5m loss --percent 100 openfire-docker-compose_xmpp1_1
fi
