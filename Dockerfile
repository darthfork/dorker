FROM fedora:38

ENV SSH_AUTH_SOCK=/tmp/ssh_auth_sock

ARG TARGETARCH
ARG USERNAME=darthfork
ARG TERRAFORM_VERSION=1.4.6
ARG KUBECTL_VERSION=1.27.1
ARG DOCTL_VERSION=1.94.0

COPY requirements.txt /tmp/requirements.txt
COPY dnf-packages.list /tmp/dnf-packages.list


RUN dnf -y update && dnf -y install dnf-plugins-core && dnf clean all

# To user docker-cli pass the id of docker group to container as group_add
RUN dnf config-manager --add-repo \
        https://download.docker.com/linux/fedora/docker-ce.repo

RUN dnf -y install $(cat /tmp/dnf-packages.list) && dnf -y clean all

RUN pip install --no-cache-dir --upgrade pip==22.3.1 && pip install --no-cache-dir -r /tmp/requirements.txt

# Install binaries not available in dnf or pip

WORKDIR /usr/local/bin

# aws cli
RUN set -ex \
    && curl -s -o awscli.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
    && unzip -d awscli awscli.zip \
    && ./awscli/aws/install \
    && rm -rf awscli.zip awscli

# kubectl
RUN set -ex \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl \
    && chmod 755 kubectl

# terraform
RUN set -ex \
    && curl -s -o terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${TARGETARCH}.zip \
    && unzip terraform.zip \
    && rm -f terraform.zip \
    && chmod 755 terraform

# DOCTL
RUN set -ex \
    && curl -sL -o doctl.tar.gz https://github.com/digitalocean/doctl/releases/download/v${DOCTL_VERSION}/doctl-${DOCTL_VERSION}-linux-${TARGETARCH}.tar.gz\
    && tar xf doctl.tar.gz\
    && rm -f doctl.tar.gz\
    && chmod 755 doctl

# helm
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

RUN groupadd -g 1000 -r ${USERNAME} &&\
    useradd -r -g ${USERNAME} -u 1000 -m -d /${USERNAME}/ ${USERNAME}

WORKDIR /${USERNAME}/workspace/

USER 1000
