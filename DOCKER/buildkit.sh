#!/bin/bash
#
# https://docs.docker.com/build/buildkit/
# https://github.com/docker/buildx/releases/
# https://github.com/docker/buildx

mkdir -p $HOME/.docker/cli-plugins
wget https://github.com/docker/buildx/releases/download/v0.11.2/buildx-v0.11.2.linux-amd64
chmod +x buildx-v0.11.2.linux-amd64
mv buildx-v0.11.2.linux-amd64 $HOME/.docker/cli-plugins/docker-buildx

export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1