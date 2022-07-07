#!/bin/zsh

WD=$(pwd)

DOCKER_PATH=$(sed 's/^.*\(html.*\).*$/\1/' <<<"$WD")
FOLDER_CHECK='html'

if [[ "$DOCKER_PATH" == *"$FOLDER_CHECK"* ]]; then
  docker exec -ti -w "/var/www/$DOCKER_PATH" academy-php php "$1"
else
  php "$1"
fi

