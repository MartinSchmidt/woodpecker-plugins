# Docker-in-docker

This plugin should be set as a `Priviledged plugin` on ther server side to work properly.
Then the individual repositories to not need to set the `priviledged: true` flag on each usage.

```yaml
WOODPECKER_PLUGINS_PRIVILEGED: 'ghcr.io/martinschmidt/woodpecker-dind:29.0.2'
```

Basic example usage:

```yaml
services:
  - name: docker
    image: ghcr.io/martinschmidt/woodpecker-dind:29.0.2

steps:
  - name: test-docker
    image: docker:cli
    environment:
      DOCKER_HOST: 'tcp://docker:2376'
      DOCKER_CERT_PATH: '/woodpecker/dind/certs/client'
      DOCKER_TLS_VERIFY: '1'
    commands:
      - sleep 5 # wait for docker daemon to be ready
      - docker run hello-world
```

## Settings

folder: defines the folder in the /woodpecker where the Docker TLS certificates and environment file will be stored. Default is `dind`.

```yaml

when:
  - event: push
    branch: main

services:
  - name: docker
    image: ghcr.io/martinschmidt/woodpecker-dind:29.0.2
    settings:
      folder: docker-in-docker

steps:
  - name: test-docker
    image: docker:cli
    environment:
      DOCKER_HOST: 'tcp://docker:2376'
      DOCKER_CERT_PATH: '/woodpecker/docker-in-docker/certs/client'
      DOCKER_TLS_VERIFY: '1'
    commands:
      - sleep 5 # wait for docker daemon to be ready
      - docker run hello-world

```
