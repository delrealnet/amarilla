#!/usr/bin/env bash

set -e -u -x -o pipefail

certbot certonly -n --standalone --register-unsafely-without-email --agree-tos -d amarilla.delreal.net

chmod go+rx /etc/letsencrypt/archive /etc/letsencrypt/live
chmod go+r /etc/letsencrypt/archive/amarilla.delreal.net/privkey*.pem

docker-compose pull

docker-compose up --build --detach

sleep 30

docker-compose exec grocy rm /config/keys/cert.crt /config/keys/cert.key

docker-compose exec grocy ln -s /etc/letsencrypt/live/amarilla.delreal.net/privkey.pem /config/keys/cert.key

docker-compose exec grocy ln -s /etc/letsencrypt/live/amarilla.delreal.net/fullchain.pem /config/keys/cert.crt

docker-compose exec grocy nginx -s reload -c /config/nginx/nginx.conf
