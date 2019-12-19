.PHONY: clean upload

DIR			:= ${CURDIR}
IMAGE			:= fedora_dev
ACCOUNT			:= abhi56rai
TAG			:= latest
REPO 			:= $(ACCOUNT)/$(IMAGE):$(TAG)
TERRAFORM_VERSION	:= 0.12.18

all: build

build:
	docker build\
		--build-arg TERRAFORM_VERSION=$(TERRAFORM_VERSION)\
		-t $(IMAGE) .

tag:
	docker tag $(IMAGE):$(TAG) $(REPO)

push:
	docker push $(REPO)
