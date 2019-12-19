# Fedora Dev Docker
Fedora Docker with all my commonly used dev tools installed

### Starting the container

```
docker run -it\
  -v $HOME/.ssh:/root/.ssh\
  -v $HOME/workspace:/workspace\
  -v $HOME/.aws:/root/.aws\
  -h arai_fedora_docker\
  abhi56rai/fedora_dev:latest
```
