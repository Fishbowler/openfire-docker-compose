# Delayed Database configuration

In an attempt to reproduce OF-2074, running `./start.sh` will perform some cleanup then start the containers, with a configuration that will delay the database start by 20 seconds.

Openfire is configured with the following XMPP domain:

* `xmpp.localhost.example`

Openfire is configured with the following hostnames:

* `xmpp.localhost.example`

The following users are configured:

* `user1` `password`
* `user2` `password`

The following MUC rooms are configured:

* `muc1`
* `muc2`

## Network

The Docker compose file defines a custom bridge network with a single subnet of `172.70.0.0/24` for the clustered configuration.
