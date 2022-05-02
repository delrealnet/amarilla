#!/usr/bin/env bash

set -e -u -x -o pipefail

certbot certonly -n --standalone --register-unsafely-without-email --agree-tos -d amarilla.delreal.net

chmod go+rx /etc/letsencrypt/archive /etc/letsencrypt/live
chmod go+r /etc/letsencrypt/archive/amarilla.delreal.net/privkey*.pem

export GROCY_MODE=production
export GROCY_IMAGE_TAG=v3.2.0-1

! [ -d grocy-docker ] && git clone https://github.com/delrealnet/grocy-grocy-docker.git grocy-docker

cd grocy-docker

git pull --rebase origin main

docker-compose pull

docker-compose up --build --detach
