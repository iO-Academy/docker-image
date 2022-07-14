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

echo_success () {
  if (( $# == 2 )) && (($2 == true)) then
    echo "${BOLD_GREEN}${1}${COLOUR_OFF}"
  else
    echo "${GREEN}${1}${COLOUR_OFF}"
  fi
}

echo_warning () {
  if (( $# == 2 )) && (($2 == true)) then
    echo "${BOLD_YELLOW}${1}${COLOUR_OFF}"
  else
    echo "${YELLOW}${1}${COLOUR_OFF}"
  fi
}

echo_fail () {
  if (( $# == 2 )) && (($2 == true)) then
    echo "${BOLD_RED}${1}${COLOUR_OFF}"
  else
    echo "${RED}${1}${COLOUR_OFF}"
  fi
}

# Set the path based on whether or not we want a trainer or student install
if [[ "$1" == "trainer" ]]; then
  SCRIPT_PATH=build/scripts/trainer
else
  SCRIPT_PATH=build/scripts/student
fi

echo "PHPUnit: Attempting to install the phpunit.sh helper script"

PHPUNIT_FILE=~/phpunit.sh

# Checks to see if the file is already in ~
if [ -f "$PHPUNIT_FILE" ]; then
  echo_warning "PHPUnit: Looks like you already have the phpunit.sh script installed"
else
  # Move the file to the home directory
  cp "$SCRIPT_PATH/phpunit.sh" ~
  # Make the sh file executable
  chmod +x ~/phpunit.sh
  # Did chmod work?
  if [ -x "$PHPUNIT_FILE" ]; then
    # Add an alias to .zshrc
    echo "alias phpunit='~/phpunit.sh'" >> ~/.zshrc
    INSTALLED=true
    echo_success "PHPUnit: phpunit.sh installed successfully"
  else
    ERROR=true
    echo_fail "PHPUnit: Error unable to make phpunit.sh executable"
  fi
fi

echo "Composer: Attempting to install the composer.sh helper script"

COMPOSER_FILE=~/composer.sh

if [ -f "$COMPOSER_FILE" ]; then
  echo_warning "Composer: Looks like you already have the composer.sh script installed"
else
  cp "$SCRIPT_PATH/composer.sh" ~
  chmod +x ~/composer.sh
  if [ -x "$COMPOSER_FILE" ]; then
    echo "alias composer='~/composer.sh'" >> ~/.zshrc
    INSTALLED=true
    echo_success "Composer: composer.sh installed successfully"
  else
    ERROR=true
    echo_fail "Composer: Error unable to make composer.sh executable"
  fi
fi

echo "PHP: Attempting to install the php.sh helper script"

PHP_FILE=~/php.sh

if [ -f "$PHP_FILE" ]; then
  echo_warning "PHP: Looks like you already have the php.sh script installed"
else
  cp "$SCRIPT_PATH/php.sh" ~
  chmod +x ~/php.sh
  if [ -x "$PHP_FILE" ]; then
    echo "alias php='~/php.sh'" >> ~/.zshrc
    INSTALLED=true
    echo_success "PHP: php.sh installed successfully"
  else
    ERROR=true
    echo_fail "PHP: Error unable to make php.sh executable"
  fi
fi

# If any of the installs ran, use exec to reload zsh
if $INSTALLED; then
    echo_success "Install complete" true
    # source doesn't work here - shell scripts run in a separate shell so source won't
    # actually effect the current terminal
    exec /bin/zsh
else
  if $ERROR; then
    echo_fail "Error: Install failed" true
  else
    echo_success "Install already complete" true
  fi
fi