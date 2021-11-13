FROM fedora:35

ENV SSH_AUTH_SOCK=/tmp/ssh_auth_sock

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG USERNAME=darthfork
ARG TERRAFORM_VERSION=1.0.4
ARG KUBECTL_VERSION=v1.20.0
ARG MUSTACHE_VERSION=1.2.2
ARG DOCTL_VERSION=1.64.0

COPY requirements.txt /

RUN dnf -y update && dnf -y install dnf-plugins-core

# To user docker-cli pass the id of docker group to container as group_add
RUN dnf config-manager --add-repo \
        https://download.docker.com/linux/fedora/docker-ce.repo

RUN dnf -y install wget make gcc unzip python3 python3-pip\
                   docker-ce-cli openssh-clients git clang-analyzer\
                   kernel-devel valgrind rust cargo golang openssl\
                   && dnf -y clean all

RUN pip install --no-cache-dir --upgrade pip==21.1.1 && pip install --no-cache-dir -r /requirements.txt

# Install binaries not available in dnf or pip

WORKDIR /usr/local/bin
# kubectl
RUN set -ex \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod 755 kubectl

# terraform
RUN set -ex \
    && curl -s -o terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform.zip \
    && rm -f terraform.zip \
    && chmod 755 terraform

# mustache
RUN set -ex \
    && curl -sL -o mustache.tar.gz https://github.com/cbroglie/mustache/releases/download/v${MUSTACHE_VERSION}/mustache_${MUSTACHE_VERSION}_linux_amd64.tar.gz\
    && tar xzf mustache.tar.gz\
    && rm -f mustache.tar.gz\
    && chmod 755 mustache

# DOCTL
RUN set -ex \
    && curl -sL -o doctl.tar.gz https://github.com/digitalocean/doctl/releases/download/v${DOCTL_VERSION}/doctl-${DOCTL_VERSION}-linux-amd64.tar.gz\
    && tar xf doctl.tar.gz\
    && rm -f doctl.tar.gz\
    && chmod 755 doctl

# helm
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

RUN groupadd -g 1000 -r ${USERNAME} &&\
    useradd -r -g ${USERNAME} -u 1000 -m -d /${USERNAME}/ ${USERNAME}

WORKDIR /${USERNAME}/workspace/

USER 1000
