FROM ubuntu:24.04

LABEL org.opencontainers.image.source="https://github.com/darthfork/dorker"

ARG DEBIAN_FRONTEND=noninteractive
ARG TARGETARCH
ARG USERNAME=darthfork

COPY apt-packages.list /tmp/apt-packages.list

RUN apt-get update \
    && xargs -a /tmp/apt-packages.list apt-get install -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* /tmp/apt-packages.list

# Install binaries not available in apt, or where apt lags too far behind.

WORKDIR /usr/local/bin

# aws cli
RUN set -ex \
    && if [ "$TARGETARCH" = "arm64" ]; then \
        curl -sSLo awscli.zip https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip; \
    else \
        curl -sSLo awscli.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip; \
    fi \
    && unzip -q -d awscli awscli.zip \
    && ./awscli/aws/install \
    && rm -rf awscli.zip awscli

# kubectl
ARG KUBECTL_VERSION=1.31.0
RUN set -ex \
    && curl -fsSLO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl \
    && chmod 755 kubectl

# terraform
ARG TERRAFORM_VERSION=1.9.8
RUN set -ex \
    && curl -fsSLo terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${TARGETARCH}.zip \
    && unzip -q terraform.zip \
    && rm -f terraform.zip \
    && chmod 755 terraform

# helm
RUN set -ex \
    && curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

RUN groupadd -g 1000 -r ${USERNAME} \
    && useradd -r -g ${USERNAME} -u 1000 -m -d /${USERNAME}/ ${USERNAME}

WORKDIR /${USERNAME}/workspace/

USER 1000
