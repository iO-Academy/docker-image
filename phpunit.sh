#!/bin/zsh

WD=$(pwd)

DOCKER_PATH=$(sed 's/^.*\(html.*\).*$/\1/' <<<"$WD")

docker exec -w "/var/www/$DOCKER_PATH"  academy-php phpunit "$1"