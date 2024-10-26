FROM fedora:40

ARG TARGETARCH
ARG USERNAME=darthfork

COPY dnf-packages.list /tmp/dnf-packages.list

RUN dnf -y update && dnf -y install $(cat /tmp/dnf-packages.list) && dnf -y clean all

# Install binaries not available in dnf

WORKDIR /usr/local/bin

# aws cli
RUN set -ex \
    && if [ "$TARGETARCH" = "arm64" ]; then \
        curl -s -o awscli.zip https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip; \
    else \
        curl -s -o awscli.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip; \
    fi \
    && unzip -d awscli awscli.zip \
    && ./awscli/aws/install \
    && rm -rf awscli.zip awscli

# kubectl
ARG KUBECTL_VERSION=1.31.0
RUN set -ex \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl \
    && chmod 755 kubectl

# terraform
ARG TERRAFORM_VERSION=1.9.8
RUN set -ex \
    && curl -s -o terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${TARGETARCH}.zip \
    && unzip terraform.zip \
    && rm -f terraform.zip \
    && chmod 755 terraform

# helm
RUN set -ex \
    && curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

RUN groupadd -g 1000 -r ${USERNAME} &&\
    useradd -r -g ${USERNAME} -u 1000 -m -d /${USERNAME}/ ${USERNAME}

WORKDIR /${USERNAME}/workspace/

USER 1000
