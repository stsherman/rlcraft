#!/usr/bin/env bash

# Get the current user based on the UID value
USER=$(cat /etc/passwd | grep :$UID: | cut -d ':' -f1)

# If there is no user with the UID, add one with the UID and change ownership of /rlcraft
if [[ -z "$USER" ]]; then
    adduser -u $UID --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password rlcraftuser
    chown -R $UID /rlcraft
    USER=rlcraftuser
fi
# If there is a GID passed, add a new group with the GID and change the current users primary group to it then change ownership of /rlcraft and give groups same permissions as user for /rlcraft
if [[ -n "$GID" ]]; then
    groupadd rlcraftgroup -g $GID
    usermod -g rlcraftgroup $USER
    chown -R $UID:$GID /rlcraft
    chmod -R g=u /rlcraft
    umask 002
fi
# Run the jar as the correct user
su $USER <<SHT
    cd /rlcraft
    java -jar forge-1.12.2-14.23.5.2860.jar
SHT
