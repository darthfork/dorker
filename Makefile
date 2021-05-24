.PHONY: build push

DIR		:= ${CURDIR}
IMAGE		:= dorker
ACCOUNT		:= darthfork
TAG		:= latest
TAG_OS		:= fedora34
REPO 		:= $(ACCOUNT)/$(IMAGE):$(TAG)
REPO_OS 	:= $(ACCOUNT)/$(IMAGE):$(TAG_OS)

all: build

build:
	docker build -t $(IMAGE):$(TAG) .

tag:
	docker tag $(IMAGE):$(TAG) $(REPO)
	docker tag $(IMAGE):$(TAG) $(REPO_OS)

push: tag
	docker push $(REPO)
	docker push $(REPO_OS)

lint:
	hadolint Dockerfile
