#!/bin/zsh

# This file is used to install the docker 'helper' scripts for
# PHP, PHPUnit and Composer, allowing us to run them via docker
# without having to manually use docker exec commands.

# It firstly checks to make sure they aren't each already installed
# then copies them into ~, chmods them and adds an alias to ~/.zshrc
# to run the helper scripts instead of your locally installed versions.

# Used to work out whether or not we need to source ~/.zshrc
INSTALLED=false
ERROR=false

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BOLD_GREEN='\033[1;32m'
BOLD_RED='\033[1;31m'
BOLD_YELLOW='\033[1;33m'
COLOUR_OFF='\033[0m'

echo "PHPUnit: Attempting to install the phpunit.sh helper script"

PHPUNIT_FILE=~/phpunit.sh

# Checks to see if the file is already in ~
if [ -f "$PHPUNIT_FILE" ]; then
  echo "${YELLOW}PHPUnit: Looks like you already have the phpunit.sh script installed${COLOUR_OFF}"
else
  # Move the file to the home directory
  cp phpunit.sh ~
  # Make the sh file executable
  chmod +x ~/phpunit.sh
  # Did chmod work?
  if [ -x "$PHPUNIT_FILE" ]; then
    # Add an alias to .zshrc
    echo "alias phpunit='~/phpunit.sh'" >> ~/.zshrc
    INSTALLED=true
    echo -e "${GREEN}PHPUnit: phpunit.sh installed successfully${COLOUR_OFF}"
  else
    ERROR=true
    echo "${RED}PHPUnit: Error unable to make phpunit.sh executable${COLOUR_OFF}"
  fi
fi

echo "Composer: Attempting to install the composer.sh helper script"

COMPOSER_FILE=~/composer.sh

if [ -f "$COMPOSER_FILE" ]; then
  echo "${YELLOW}Composer: Looks like you already have the composer.sh script installed${COLOUR_OFF}"
else
  cp composer.sh ~
  chmod +x ~/composer.sh
  if [ -x "$COMPOSER_FILE" ]; then
    echo "alias composer='~/composer.sh'" >> ~/.zshrc
    INSTALLED=true
    echo "${GREEN}Composer: composer.sh installed successfully${COLOUR_OFF}"
  else
    ERROR=true
    echo "${RED}Composer: Error unable to make composer.sh executable${COLOUR_OFF}"
  fi
fi

echo "PHP: Attempting to install the php.sh helper script"

PHP_FILE=~/php.sh

if [ -f "$PHP_FILE" ]; then
  echo "${YELLOW}PHP: Looks like you already have the php.sh script installed${COLOUR_OFF}"
else
  cp php.sh ~
  chmod +x ~/php.sh
  if [ -x "$PHP_FILE" ]; then
    echo "alias php='~/php.sh'" >> ~/.zshrc
    INSTALLED=true
    echo "${GREEN}PHP: php.sh installed successfully${COLOUR_OFF}"
  else
    ERROR=true
    echo "${RED}PHP: Error unable to make php.sh executable${COLOUR_OFF}"
  fi
fi

# If any of the installs ran, source ~/.zshrc
if $INSTALLED; then
    echo "Sourcing .zshrc"
    source ~/.zshrc
    echo "${BOLD_GREEN}Install complete${COLOUR_OFF}"
else
  if $ERROR; then
    echo "${BOLD_RED}Error: Install failed${COLOUR_OFF}"
  else
    echo "${BOLD_YELLOW}Install already complete${COLOUR_OFF}"
  fi
fi