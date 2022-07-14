#!/bin/zsh

WD=$(pwd)

DOCKER_PATH=$(sed 's/^.*\(html.*\).*$/\1/' <<<"$WD")
FOLDER_CHECK='html'

RED='\033[0;31m'
COLOUR_OFF='\033[0m'

if [[ "$DOCKER_PATH" == *"$FOLDER_CHECK"* ]]; then
  docker exec -ti -w "/var/www/$DOCKER_PATH" academy-php php "$1"
else
  echo "Local version"
  php "$1"
fi

