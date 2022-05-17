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

/home/steam/steamcmd/steamcmd.sh +force_install_dir /corekeeper/game +login anonymous +app_update 1963720 +quit
/home/steam/steamcmd/steamcmd.sh +force_install_dir /corekeeper/steamworks +login anonymous +app_update 1007 +quit

cd game
trap kill_corekeeperserver EXIT

if ! (dpkg -l xvfb >/dev/null) ; then
    echo "Installing xvfb dependency..."
    sleep 1
    sudo apt-get update -yy && sudo apt-get install xvfb -yy
fi

set -m

rm -f /tmp/.X99-lock

Xvfb :99 -screen 0 1x1x24 -nolisten tcp &
xvfbpid=$!


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
