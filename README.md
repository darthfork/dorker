# Dorker
Fedora Docker with all my commonly used dev tools installed

[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/darthfork/dorker/Docker%20Push?style=for-the-badge&logo=github)](https://github.com/darthfork/dorker/actions?query=workflow%3A%22Docker+Push%22)
[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/darthfork/dorker/latest?logo=docker&style=for-the-badge)](https://hub.docker.com/r/darthfork/dorker/)


### Starting a shell in the container

```
docker run -it\
    -v "$HOME"/.ssh:/darthfork/.ssh\
    -v "$HOME"/workspace:/darthfork/workspace\
    -v "$HOME"/.aws:/darthfork/.aws\
    -v "$HOME"/.kube:/darthfork/.kube\
    -v "$HOME"/.helm:/darthfork/.helm\
    -v "$SSH_AUTH_SOCK":/tmp/ssh_auth_sock\
    -v "$HOME"/.vim:/darthfork/.vim\
    -v /var/run/docker.sock:/var/run/docker.sock\
    --group-add "$(getent group docker | awk -F: '{print $3}')"\
    -h dorker\
    docker.io/darthfork/dorker:latest /bin/bash
```
