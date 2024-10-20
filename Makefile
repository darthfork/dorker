.PHONY: build push

include version

.DEFAULT_GOAL := all

DIR		:= ${CURDIR}
IMAGE		:= dorker
ACCOUNT		:= darthfork
REPO 		:= $(ACCOUNT)/$(IMAGE):$(TAG)
REPO_OS 	:= $(ACCOUNT)/$(IMAGE):$(TAG_OS)
TARGETPLATFORM	:= linux/amd64,linux/arm64

all: help

help:
	@echo "Please specify a target: "
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

build: ## Build container
	docker buildx build --platform $(TARGETPLATFORM) -t $(REPO) -t $(REPO_OS) .

push: ## Build container and push to registry
push: build
	docker push $(REPO)
	docker push $(REPO_OS)

lint: ## Lint Dockerfile
	hadolint Dockerfile
