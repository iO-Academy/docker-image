#!/bin/zsh

WD=$(pwd)

DOCKER_PATH=$(sed 's/^.*\(html.*\).*$/\1/' <<<"$WD")
FOLDER_CHECK='html'

if [[ "$DOCKER_PATH" == *"$FOLDER_CHECK"* ]]; then
  DOCKER_COMMAND="docker exec -w /var/www/$DOCKER_PATH academy-php phpunit $*"
  eval $DOCKER_COMMAND
else
  echo "Local version"
  phpunit "$*"
fi

