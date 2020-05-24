# Dorker
Fedora Docker with all my commonly used dev tools installed

### Build Status

![Docker Build](https://github.com/darthfork/dorker/workflows/Docker%20Build/badge.svg)


### Starting the container

```
docker run -it\
  -v $HOME/.ssh:/root/.ssh\
  -v $HOME/workspace:/workspace\
  -v $HOME/.aws:/root/.aws\
  -v /var/run/docker.sock:/var/run/docker.sock\
  --user $(id -u):$(id -g)\
  -e USER=$USER\
  -h dorker\
  abhi56rai/dorker:latest
```
