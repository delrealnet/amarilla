#!/usr/bin/env bash

set -e -u -x -o pipefail

export GROCY_IMAGE_TAG=v3.2.0-1

! [ -d grocy-docker ] && git clone https://github.com/grocy/grocy-docker.git

cd grocy-docker

docker-compose pull

docker-compose up --build --detach
