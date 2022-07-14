#!/bin/zsh

# Grab the working directory
WD=$(pwd)

# Remove everything from the path before 'html'
DOCKER_PATH=$(sed 's/^.*\(html.*\).*$/\1/' <<<"$WD")
FOLDER_CHECK='html'

RED='\033[0;31m'
COLOUR_OFF='\033[0m'

# Make sure the current working directory is actually in docker
if [[ "$DOCKER_PATH" == *"$FOLDER_CHECK"* ]]; then
  # Execute the command through docker
  docker exec -ti -w "/var/www/$DOCKER_PATH" academy-php composer "$1"
else
  # Otherwise we're outside the html folder, so run the original command
  echo "${RED}Error: You must be in the html folder to run this command${COLOUR_OFF}"
fi
