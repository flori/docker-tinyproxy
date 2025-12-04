DOCKER_USER = flori303
DOCKER_IMAGE_NAME = tinyproxy
GITHUB_REF_NAME ?= $(shell git rev-parse --short HEAD)
DOCKER_IMAGE_VERSION = ${GITHUB_REF_NAME}
TAG := $(shell git rev-parse HEAD | cut -c 1-7)

.EXPORT_ALL_VARIABLES:

pre-build:
	docker buildx rm tinyproxy-builder || true
	docker buildx create --name tinyproxy-builder
	docker buildx use tinyproxy-builder
	docker buildx inspect --bootstrap

build: pre-build
	docker buildx build --platform linux/amd64,linux/arm64 --pull --push -t $(DOCKER_USER)/$(DOCKER_IMAGE_NAME) -t $(DOCKER_USER)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION) .

build-local: pre-build
	docker buildx build --platform linux/amd64,linux/arm64 --load -t $(DOCKER_IMAGE_NAME) .

build-info:
	@echo "$(DOCKER_USER)/$(DOCKER_IMAGE_NAME):$(TAG)"

grype: build
	@docker run --pull always --rm --volume /var/run/docker.sock:/var/run/docker.sock --name Grype anchore/grype:latest --add-cpes-if-none --by-cve "$(DOCKER_USER)/$(DOCKER_IMAGE_NAME)"

release:
	git tag $(TAG)
	git push origin $(TAG)
	git push origin
