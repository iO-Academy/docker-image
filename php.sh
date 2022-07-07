#!/bin/zsh

WD=$(pwd)

DOCKER_PATH=$(sed 's/^.*\(html.*\).*$/\1/' <<<"$WD")

docker exec -ti -w "/var/www/$DOCKER_PATH" academy-php php "$1"
