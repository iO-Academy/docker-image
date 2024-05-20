#!/bin/zsh

# Grab the working directory
WD=$(pwd)

# Remove everything from the path before 'html'
DOCKER_PATH=$(sed 's/^.*\(html.*\).*$/\1/' <<<"$WD")
FOLDER_CHECK='html'

# Make sure the current working directory is actually in docker
if [[ "$DOCKER_PATH" == *"$FOLDER_CHECK"* ]]; then
  # Execute the command through docker
  DOCKER_COMMAND="docker exec -ti -w \"/var/www/$DOCKER_PATH\" academy-php composer \"$@\""
  eval "$DOCKER_COMMAND"
else
  # Otherwise we're outside the html folder, so for trainers, run the original command
  echo "Local version"
  composer "$@"
fi