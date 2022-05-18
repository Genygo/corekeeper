FROM cm2network/steamcmd:root

RUN apt update && apt install -y --no-install-recommends --no-install-suggests xvfb
RUN mkdir /corekeeper && mkdir /corekeeper/game/ && mkdir /corekeeper/steamworks/
RUN chown -R ${USER}:${USER} /corekeeper

WORKDIR /corekeeper
COPY server.sh server.sh
RUN chmod +x server.sh && chown ${USER}:${USER} server.sh

ENV GAME_ID=""

# Switch to user
USER ${USER}
WORKDIR /home/steam/steamcmd
RUN ./steamcmd.sh +force_install_dir /corekeeper/game +login anonymous +app_update 1963720 +quit
RUN ./steamcmd.sh +force_install_dir /corekeeper/steamworks +login anonymous +app_update 1007 +quit

WORKDIR /corekeeper
CMD ["./server.sh"]
