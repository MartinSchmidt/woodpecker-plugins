#!/bin/sh

set -e

FOLDER=/woodpecker/${PLUGIN_FOLDER:-dind}
mkdir -p "${FOLDER}"
export DOCKER_TLS_CERTDIR=${FOLDER}/certs

exec "$@"