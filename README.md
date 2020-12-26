# Dorker
Fedora Docker with all my commonly used dev tools installed

[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/darthfork/dorker/Docker%20Push?style=for-the-badge&logo=github)](https://github.com/darthfork/dorker/actions?query=workflow%3A%22Docker+Push%22)
[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/darthfork/dorker/latest?logo=docker&style=for-the-badge)](https://hub.docker.com/r/darthfork/dorker/)


### Starting a shell in the container

```
docker run -it\
    -v "$HOME"/.ssh:/home/darthfork/.ssh\
    -v "$HOME"/workspace:/home/darthfork/workspace\
    -v "$HOME"/.aws:/home/darthfork/.aws\
    -v "$HOME"/.kube:/home/darthfork/.kube\
    -v "$HOME"/.vim:/home/darthfork/.vim\
    -v "$SSH_AUTH_SOCK":/tmp/ssh_auth_sock\
    -v /var/run/docker.sock:/var/run/docker.sock\
    -h dorker\
    darthfork/dorker:latest /bin/bash
```
