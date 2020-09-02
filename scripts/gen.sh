#!/bin/bash
# vim: ai:ts=8:sw=8:noet
set -eufCo pipefail
export SHELLOPTS
IFS=$'\t\n'

GEN_DIR="${GEN_DIR:-./_gen}"
OVERLAYS_DIR="${OVERLAYS_DIR:-./overlays}"

echo "Clening ${GEN_DIR}..."
rm -rf "${GEN_DIR}"
mkdir -p "${GEN_DIR}"

echo "Generating manifests..."
kustomize build "${OVERLAYS_DIR}" -o "${GEN_DIR}"