FROM fedora:32
MAINTAINER Abhishek Rai <rai.abhishek90@gmail.com>

ENV SSH_AUTH_SOCK=/tmp/ssh_auth_sock

ARG USERNAME=darthfork
ARG TERRAFORM_VERSION=0.14.3
ARG KUBECTL_VERSION=v1.20.0

ADD requirements.txt /

RUN dnf -y update && dnf -y install dnf-plugins-core

# To user docker-cli run container as root
RUN dnf config-manager --add-repo \
        https://download.docker.com/linux/fedora/docker-ce.repo

RUN dnf -y install wget make gcc awscli unzip python3 python3-pip docker-ce-cli openssh-clients vim git

RUN pip install --upgrade pip && pip install -r /requirements.txt

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

RUN groupadd -r ${USERNAME} &&\
    useradd -r -g ${USERNAME} -u 1000 -m -d /${USERNAME}/ ${USERNAME}

WORKDIR /${USERNAME}/workspace/
USER 1000
