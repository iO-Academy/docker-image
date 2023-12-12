#!/bin/zsh

# Command to kill processes running on a specific port
# For when slim/laravel gets stuck running

# Uses the fuser -k command to kill the process
# The '> /dev/null 2>&1' portion of the command hides the output from fuser,
# which can often have a bunch of meaningless permission errors
DOCKER_COMMAND="docker exec -ti academy-php fuser -k $*/tcp > /dev/null 2>&1"
eval $DOCKER_COMMAND