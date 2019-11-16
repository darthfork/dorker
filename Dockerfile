FROM fedora

RUN dnf -y update
RUN dnf -y install git wget make gcc

ENTRYPOINT ["/bin/bash"]
WORKDIR /workspace
