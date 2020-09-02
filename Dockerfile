FROM slok/kahoy:latest

RUN apk --no-cache add \
    git \
    curl \
    bash

ARG KUSTOMIZE_VERSION="v3.8.2"

RUN wget -O- https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz | tar xvz -C /usr/bin/


# Create user
ARG UID=1000
ARG GID=1000
RUN addgroup -g $GID app && \
    adduser -D -u $UID -G app app
USER app

WORKDIR /src

ENTRYPOINT []