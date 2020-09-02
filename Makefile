
OSTYPE := $(shell uname)
VERSION ?= $(shell git describe --tags --always)


IMAGE_NAME := slok/kahoy-kustomize-example

DOCKER_RUN_CMD := docker run --env ostype=$(OSTYPE) -v ${PWD}:/src --rm ${IMAGE_NAME}
BUILD_IMAGE_CMD := IMAGE=${IMAGE_NAME} DOCKER_FILE_PATH=./Dockerfile VERSION=dev TAG_IMAGE_LATEST=true ./scripts/build-image.sh

GEN_CMD := ./scripts/gen.sh
CHECK_CMD := ./scripts/check.sh


help: ## Show this help.
	@echo "Help"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "    \033[36m%-20s\033[93m %s\n", $$1, $$2}'

.PHONY: default
default: help

.PHONY: build-image
build-image: ## Builds docker image.
	@$(BUILD_IMAGE_CMD)

.PHONY: gen
gen: build-image ## Generates manifests using kustomize.
	@$(DOCKER_RUN_CMD) /bin/sh -c '$(GEN_CMD)'

.PHONY: check
check: build-image ## Generates manifests using kustomize.
	@$(DOCKER_RUN_CMD) /bin/sh -c '$(CHECK_CMD)'
