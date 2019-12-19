FROM fedora

ARG TERRAFORM_VERSION

RUN dnf -y update
RUN dnf -y install wget make gcc awscli unzip

# Install binaries not available in dnf
RUN set -ex \
    && cd /usr/local/bin \
    && curl -s -o /terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip /terraform.zip \
    && rm -f /terraform.zip \
    && chmod 755 terraform

ENTRYPOINT ["/bin/bash"]
WORKDIR /workspace
