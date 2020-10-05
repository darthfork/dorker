.PHONY: build push

DIR			:= ${CURDIR}
IMAGE			:= dorker
ACCOUNT			:= abhi56rai
TAG			:= latest
REPO 			:= $(ACCOUNT)/$(IMAGE):$(TAG)

all: build

build:
	docker build -t $(IMAGE) .

tag:
	docker tag $(IMAGE):$(TAG) $(REPO)

push: tag
	docker push $(REPO)
