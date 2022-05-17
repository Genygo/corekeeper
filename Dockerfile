############################################################
# Dockerfile that contains SteamCMD
############################################################
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

WORKDIR /corekeeper

CMD ["./server.sh"]
