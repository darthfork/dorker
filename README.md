# Dorker
Fedora Docker with all my commonly used dev tools installed

[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/darthfork/dorker/build.yml?style=for-the-badge&logo=github)](https://github.com/darthfork/dorker/actions/workflows/build.yml)
[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/darthfork/dorker/latest?logo=docker&style=for-the-badge)](https://hub.docker.com/r/darthfork/dorker/)


### Starting a shell in the container

```
docker run -it\
    -v "$HOME"/.ssh:/darthfork/.ssh\
    -v "$HOME"/workspace:/darthfork/workspace\
    -v "$HOME"/.aws:/darthfork/.aws\
    -v "$HOME"/.kube:/darthfork/.kube\
    -v "$HOME"/.helm:/darthfork/.helm\
    -e DO_TOKEN\
    -h dorker\
    docker.io/darthfork/dorker:latest /bin/bash
```
