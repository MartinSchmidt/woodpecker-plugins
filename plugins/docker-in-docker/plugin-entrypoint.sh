#!/bin/sh

if [ -z "$CI_STEP_NAME" ]; then
    echo "Error: CI_STEP_NAME is not set"
    exit 1
fi

FOLDER=/woodpecker/${PLUGIN_FOLDER:-dind}
mkdir -p "${FOLDER}"


export DOCKER_TLS_CERTDIR=${FOLDER}/certs

cat <<EOF > "${FOLDER}/.env"
export DOCKER_HOST='tcp://${CI_STEP_NAME}:2376'
export DOCKER_CERT_PATH="${DOCKER_TLS_CERTDIR}/client"
export DOCKER_TLS_VERIFY=1
EOF

exec "$@"