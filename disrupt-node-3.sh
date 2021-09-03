#!/bin/sh
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba netem --target 172.60.0.10 --target 172.60.0.20 --duration 5m loss --percent 100 openfire-docker-compose_xmpp3_1
