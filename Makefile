IMAGE?=kameshsampath/drone-mkdocs-site
TAG?=latest
SHELL := bash
CURRENT_DIR = $(shell pwd)
BUILDER=buildx-multi-arch
DOCKER_FILE=$(CURRENT_DIR)/docker/Dockerfile

prepare-buildx: ## Create buildx builder for multi-arch build, if not exists
	docker buildx inspect $(BUILDER) || docker buildx create --name=$(BUILDER) --driver=docker-container --driver-opt=network=host

build-plugin: ## Build plugin image locally
	docker build --tag=$(IMAGE):$(TAG) -f $(DOCKER_FILE) .

push-plugin: prepare-buildx ## Build & Upload extension image to hub. Do not push if tag already exists: TAG=$(svu c) make push-extension
	docker pull $(IMAGE):$(shell svu c) && echo "Failure: Tag already exists" || docker buildx build --push --builder=$(BUILDER) --platform=linux/amd64,linux/arm64 --build-arg TAG=$(shell svu c) --tag=$(IMAGE):$(shell svu c) -f $(DOCKER_FILE) .

release:	
	git tag "$(shell svu next)"
	git push --tags

help: ## Show this help
	@echo Please specify a build target. The choices are:
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "$(INFO_COLOR)%-30s$(NO_COLOR) %s\n", $$1, $$2}'

.PHONY: bin build-plugin push-plugin help