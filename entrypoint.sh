#!/bin/bash

if [[ -n "$UID" && "$UID" -ne "0" ]]; then
  echo "Using UID of $UID"
  chown -R $UID /rlcraft
  adduser -u $UID rlcraftuser --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
else
  echo "Adding rlcraft user"
  adduser rlcraftuser --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
fi
if [[ -n "$GID" ]]; then
  groupadd rlcraftgroup -g $GID
  chown -R :$GID /rlcraft
  chmod -R g=u /rlcraft
  usermod -a -G rlcraftgroup rlcraftuser
fi

su rlcraftuser <<SHT
     cd /rlcraft
     java -jar forge-1.12.2-14.23.5.2860.jar
SHT
