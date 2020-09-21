#!/bin/bash
# vim: ai:ts=8:sw=8:noet
set -eufCo pipefail
export SHELLOPTS
IFS=$'\t\n'

MANIFESTS_PATH="${MANIFESTS_PATH:-./_gen}"
GIT_BEFORE_COMMIT_SHA="${GIT_BEFORE_COMMIT_SHA:-}"
GIT_DEFAULT_BRANCH="${GIT_DEFAULT_BRANCH:-master}" # In case our default branch is different (e.g main).
CLUSTER_ENV="${CLUSTER_ENV:-}"

[ -z "$CLUSTER_ENV" ] && echo "CLUSTER_ENV env is required" && exit 1;


echo "Kahoy running against ${CLUSTER_ENV}..."

case "${1:-"dry-run"}" in
"run")
    #kahoy apply \
    #    --include-changes \
    #    --git-before-commit-sha "${GIT_BEFORE_COMMIT_SHA}" \
    #    --git-default-branch "${GIT_DEFAULT_BRANCH}" \
    #    --fs-new-manifests-path "${MANIFESTS_PATH}" \
    #    -l "env=${CLUSTER_ENV}"
    echo "NOOP until we have a running cluster on CI"
    ;;
"diff")
     #kahoy apply \
     #    --diff \
     #    --include-changes \
     #    --git-before-commit-sha "${GIT_BEFORE_COMMIT_SHA}" \
     #    --git-default-branch "${GIT_DEFAULT_BRANCH}" \
     #    --fs-new-manifests-path "${MANIFESTS_PATH}" \
     #    -l "env=${CLUSTER_ENV}" | colordiff
     echo "NOOP until we have a running cluster on CI"
    ;;
"dry-run")
    kahoy apply \
        --dry-run \
        --include-changes \
        --git-before-commit-sha "${GIT_BEFORE_COMMIT_SHA}" \
        --git-default-branch "${GIT_DEFAULT_BRANCH}" \
        --fs-new-manifests-path "${MANIFESTS_PATH}" \
        -l "env=${CLUSTER_ENV}"
    ;;
"sync-all")
    echo "This should be without dry-run, but we don't have a running cluster"
    kahoy apply \
       --dry-run \
       --provider="paths" \
       --fs-old-manifests-path /dev/null \
       --fs-new-manifests-path "${MANIFESTS_PATH}" \
       -l "env=${CLUSTER_ENV}"
    ;;
*)
    echo "ERROR: Unknown command"
    exit 1
    ;;
esac
