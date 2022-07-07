#!/bin/zsh

WD=$(pwd)

DOCKER_PATH=$(sed 's/^.*\(html.*\).*$/\1/' <<<"$WD")
FOLDER_CHECK='docker-image/html'

if [[ "$DOCKER_PATH" == *"$FOLDER_CHECK"* ]]; then
  docker exec -ti -w "/var/www/$DOCKER_PATH" academy-php composer "$1"
else
  echo "You need to be in the html folder!."
fi
