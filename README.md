# Core Keeper Dedicated Server
![corekeeper](https://user-images.githubusercontent.com/136487/168213246-7f561105-136e-47fa-abd9-fac1c97ca48d.png)
Core Keeper Dedicated Server in a Docker Container [Docker Hub ](https://hub.docker.com/r/genygo/corekeeper). [REPO](https://github.com/Genygo/corekeeper)

## Features
- Automatically update server on container start
- Keep GameID after restart

## Usage
Use docker-compose.yml example
Note: You have to make sure, that the mounted volume has the right owner (1000:1000)
```bash
# Basic usage
# Clone the repo
git clone git@github.com:Genygo/corekeeper.git

# bring up the container
docker-compose up -d

# get GameID
docker exec corekeeper cat GameID.txt

```


### Volumes
In order to persist your server's data between restarts, the `/corekeeper/game` directory must be kept in a volume. A bind mount is recommended to easily adjust the files yourself, but if you don't need to transfer files into the container an ephemeral volume will work as well.

See `docker-compose.yml`

