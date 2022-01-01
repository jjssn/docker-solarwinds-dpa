#!/bin/bash
./init.sh
./startup.sh -D
while pgrep -x java >/dev/null; do
    #echo "DPA is already running"
    sleep 60s;
done