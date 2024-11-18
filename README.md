# Dorker
Fedora Docker with all my commonly used dev tools installed

[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/darthfork/dorker/ci.yaml?style=for-the-badge&logo=github)](https://github.com/darthfork/dorker/actions/workflows/ci.yaml)

[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/darthfork/dorker/latest?logo=docker&style=for-the-badge)](https://hub.docker.com/r/darthfork/dorker/)


## Starting a shell in the container

```
docker run -it\
    -v "$HOME"/workspace:/darthfork/workspace\
    -v "$HOME"/.aws:/darthfork/.aws\
    -v "$HOME"/.kube:/darthfork/.kube\
    -e AWS_PROFILE\
    -h dorker\
    docker.io/darthfork/dorker:latest /bin/bash
```

## Run `dorker` in Kubernetes

`dorker` can be run in kubernetes as a debugging tool. To run `dorker` in Kubernetes use the [dorker kubernetes plugin](https://github.com/darthfork/dotfiles/blob/main/.local/bin/kubectl-dorker) (`kubectl dorker`). The plugin uses the kubernetes [configuration](https://github.com/darthfork/dotfiles/blob/main/.config/utils/kubernetes.yaml) from my [dotfiles](https://github.com/darthfork/dotfiles) repository.

## Run `dorker` using Docker Compose

To run `dorker` using docker-compose use the `dorker` [binary](https://github.com/darthfork/dotfiles/blob/main/.local/bin/dorker) which uses the [compose](https://github.com/darthfork/dotfiles/blob/main/.config/utils/compose.yaml) configuration from my [dotfiles](https://github.com/darthfork/dotfiles) repository.
