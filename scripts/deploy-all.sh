#!/bin/bash
# vim: ai:ts=8:sw=8:noet
set -eufCo pipefail
export SHELLOPTS
IFS=$'\t\n'

CLUSTER_ENVS="${CLUSTER_ENVS:-./overlays}"

# Execute deploy.sh on all available envs.
set +f
for dir in "${CLUSTER_ENVS}"/*/; do
    cluster_env="$(basename ${dir})"
    echo "# USING ${cluster_env}"
    CLUSTER_ENV="${cluster_env}" ./scripts/deploy.sh "$@"
done
set -f