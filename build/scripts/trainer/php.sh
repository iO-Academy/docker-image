#!/bin/zsh

WD=$(pwd)

DOCKER_PATH=$(sed 's/^.*\(html.*\).*$/\1/' <<<"$WD")
FOLDER_CHECK='html'

if [[ "$DOCKER_PATH" == *"$FOLDER_CHECK"* ]]; then
  DOCKER_COMMAND="docker exec -ti -w \"/var/www/$DOCKER_PATH\" academy-php php \"$@\""
  eval "$DOCKER_COMMAND"
else
  echo "Local version"
  php "$@"
fi