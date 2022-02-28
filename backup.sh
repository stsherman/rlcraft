#!/usr/bin/env bash

# We want to back up:
## World
## banned-ips.json
## banned-players.json
## ops.json
## server.properties
## whitelist.json
### Essentially *.json

## $(date "+%Y%m%d-%H%M%S")-rlcraft


# Script should allow backing up and restoring from backups

# If backing up
## Pause docker container or stop server using server commands (still need to figure out how to do this programmatically)
## Tarball all the files/directories listed above named with the date and time
## Move Tarball to a backup folder
## Resume docker container or server

# If restoring a backup
## Verify that the file given exists
## Verify that the working directory has the other necessary files to run the server (not sure if this is necessary)
## Pause docker container or stop server using server commands (still need to figure out how to do this programmatically)
## Extract tarball and overwrite files/directories
## Resume docker container or server


# TODO
## Figure out how to avoid issues with the session.lock
## Figure out issues with sending server commands programmatically

# backup

mkdir -p Backups
tar -czvf Backups/$(date "+%Y%m%d-%H%M%S")-rlcraft.tar.gz \
  ./World \
  ./banned-ips.json \
  ./banned-players.json \
  ./ops.json \
  ./server.properties \
  ./whitelist.json
