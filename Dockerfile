FROM fedora:31
MAINTAINER Abhishek Rai <rai.abhishek90@gmail.com>

ARG TERRAFORM_VERSION=0.13.5
ARG KUBECTL_VERSION=v1.20.0

RUN dnf -y update && dnf -y install wget make gcc awscli unzip python3 python3-pip dnf-plugins-core

# Install Docker CLI for drone builds
RUN dnf config-manager --add-repo \
        https://download.docker.com/linux/fedora/docker-ce.repo

RUN dnf -y install docker-ce-cli


# Install binaries not available in dnf
RUN set -ex \
    && cd /usr/local/bin \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod 755 kubectl

RUN set -ex \
    && cd /usr/local/bin \
    && curl -s -o /terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip /terraform.zip \
    && rm -f /terraform.zip \
    && chmod 755 terraform

WORKDIR /workspace
