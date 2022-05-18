#!/bin/bash

xvfbpid=""
ckpid=""

function kill_corekeeperserver {
        if [[ ! -z "$ckpid" ]]; then
                kill $ckpid
        fi
        sleep 1
        if [[ ! -z "$xvfbpid" ]]; then
                kill $xvfbpid
        fi
}

cd game
trap kill_corekeeperserver EXIT

set -m

rm -f /tmp/.X99-lock

Xvfb :99 -screen 0 1x1x24 -nolisten tcp &
xvfbpid=$!

ln -sf /proc/1/fd/1 ./CoreKeeperServerLog.txt
chmod +x ./CoreKeeperServer
gameID=$(cat GameID.txt)

DISPLAY=:99 LD_LIBRARY_PATH="$LD_LIBRARY_PATH:../steamworks/linux64/" \
        ./CoreKeeperServer -batchmode -gameid $gameID -logfile CoreKeeperServerLog.txt &

ckpid=$!

echo "Started server process with pid $ckpid"

while [ ! -f GameID.txt ]; do
        sleep 0.1
done

echo "Game ID: $(cat GameID.txt)"

wait $ckpid
ckpid=""
