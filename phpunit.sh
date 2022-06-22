#!/bin/zsh

WD=$(pwd)

DOCKER_PATH=$(sed 's/^.*\(html.*\).*$/\1/' <<<"$WD")

docker exec -w "/var/www/$DOCKER_PATH"  docker-image-php-1 phpunit "$1"