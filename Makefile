.PHONY: build push

include version

DIR		:= ${CURDIR}
IMAGE		:= dorker
ACCOUNT		:= darthfork
REPO 		:= $(ACCOUNT)/$(IMAGE):$(TAG)
REPO_OS 	:= $(ACCOUNT)/$(IMAGE):$(TAG_OS)
TARGETPLATFORM	:= linux/amd64,linux/arm64

all: build

build:
	docker buildx build --platform $(TARGETPLATFORM) -t $(REPO) -t $(REPO_OS) .

push: build
	docker push $(REPO)
	docker push $(REPO_OS)

lint:
	hadolint Dockerfile
