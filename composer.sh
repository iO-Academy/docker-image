#!/bin/zsh

# Grab the working directory
WD=$(pwd)

# Remove everything from the path before 'html'
DOCKER_PATH=$(sed 's/^.*\(html.*\).*$/\1/' <<<"$WD")
FOLDER_CHECK='html'

# Make sure the current working directory is actually in docker
if [[ "$DOCKER_PATH" == *"$FOLDER_CHECK"* ]]; then
  # Execute the command through docker
  docker exec -ti -w "/var/www/$DOCKER_PATH" academy-php composer "$1"
else
  # Otherwise we're outside the html folder, so run the original command
  composer "$1"
fi
