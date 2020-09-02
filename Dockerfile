FROM alpine:3

RUN apk --no-cache add \
    git \
    curl \
    bash

ARG KUBERNETES_VERSION="v1.18.8"
ARG KAHOY_VERSION="v1.0.0"
ARG KUSTOMIZE_VERSION="v3.8.2"

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl && \
    chmod a+x kubectl && \
    mv kubectl /usr/bin/ && \
    \
    curl -LO https://github.com/slok/kahoy/releases/download/${KAHOY_VERSION}/kahoy-linux-amd64 && \
    chmod a+x kahoy-linux-amd64 && \
    mv ./kahoy-linux-amd64 /usr/bin/kahoy && \
    \
    wget -O- https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz | tar xvz -C /usr/bin/


# Create user
ARG UID=1000
ARG GID=1000
RUN addgroup -g $GID app && \
    adduser -D -u $UID -G app app
USER app

WORKDIR /src