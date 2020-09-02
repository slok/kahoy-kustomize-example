#!/bin/bash
# vim: ai:ts=8:sw=8:noet
set -eufCo pipefail
export SHELLOPTS
IFS=$'\t\n'

command -v docker >/dev/null 2>&1 || { echo 'please install docker'; exit 1; }

if [ -z ${VERSION} ]; then
    echo "IMAGE_VERSION env var needs to be set"
    exit 1
fi

if [ -z ${IMAGE} ]; then
    echo "IMAGE env var needs to be set"
    exit 1
fi

if [ -z ${DOCKER_FILE_PATH} ]; then
    echo "DOCKER_FILE_PATH env var needs to be set"
    exit 1
fi

echo "Building image ${IMAGE}:${VERSION}..."
docker build \
    --build-arg VERSION=${VERSION} \
    -t ${IMAGE}:${VERSION} \
    -f ${DOCKER_FILE_PATH} .

if [ ! -z ${TAG_IMAGE_LATEST:-} ]; then
    echo "Tagged image ${IMAGE}:${VERSION} with ${IMAGE}:latest"
    docker tag ${IMAGE}:${VERSION} ${IMAGE}:latest
fi