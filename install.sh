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

echo "PHPUnit: Attempting to install the phpunit helper script"

PHPUNIT_FILE=~/phpunit.sh

# Checks to see if the file is already in ~
if [ -f "$PHPUNIT_FILE" ]; then
  echo_warning "PHPUnit: phpunit.sh file already present"
else
  # Move the file to the home directory
  cp "$SCRIPT_PATH/phpunit.sh" ~
  # Make the sh file executable
  chmod +x ~/phpunit.sh
  # Did chmod work?
  if [ -x "$PHPUNIT_FILE" ]; then
    echo_success "PHPUnit: phpunit.sh file moved successfully"
  else
    ERROR=true
    echo_fail "PHPUnit: Error unable to make phpunit.sh executable"
  fi
fi

# Checks to see if the alias already exists
if grep -qF "alias phpunit='~/phpunit.sh'" ~/.zshrc; then
  echo_warning "PHPUnit: .zshrc alias already setup"
else
  # Add an alias to .zshrc
  echo "alias phpunit='~/phpunit.sh'" >> ~/.zshrc
  # Indicate that the .zshrc file needs to be reloaded
  INSTALLED=true 
  echo_success "PHPUnit: Alias added successfully"
fi

echo "Composer: Attempting to install the composer helper script"

COMPOSER_FILE=~/composer.sh

if [ -f "$COMPOSER_FILE" ]; then
  echo_warning "Composer: composer.sh already present"
else
  cp "$SCRIPT_PATH/composer.sh" ~
  chmod +x ~/composer.sh
  if [ -x "$COMPOSER_FILE" ]; then
    echo_success "Composer: composer.sh file moved successfully"
  else
    ERROR=true
    echo_fail "Composer: Error unable to make composer.sh executable"
  fi
fi

# Checks to see if the alias already exists
if grep -qF "alias composer='~/composer.sh'" ~/.zshrc; then
  echo_warning "Composer: .zshrc alias already setup"
else
  # Add an alias to .zshrc
  echo "alias composer='~/composer.sh'" >> ~/.zshrc
  # Indicate that the .zshrc file needs to be reloaded
  INSTALLED=true
  echo_success "Composer: Alias added successfully"
fi

echo "PHP: Attempting to install the php helper script"

PHP_FILE=~/php.sh

if [ -f "$PHP_FILE" ]; then
  echo_warning "PHP: php.sh already present"
else
  cp "$SCRIPT_PATH/php.sh" ~
  chmod +x ~/php.sh
  if [ -x "$PHP_FILE" ]; then
    echo_success "PHP: php.sh file moved successfully"
  else
    ERROR=true
    echo_fail "PHP: Error unable to make php.sh executable"
  fi
fi

# Checks to see if the alias already exists
if grep -qF "alias php='~/php.sh'" ~/.zshrc; then
  echo_warning "PHP: .zshrc alias already setup"
else
  # Add an alias to .zshrc
  echo "alias php='~/php.sh'" >> ~/.zshrc
  # Indicate that the .zshrc file needs to be reloaded
  INSTALLED=true
  echo_success "PHP: Alias added successfully"
fi

echo "STOP: Attempting to install the stop. helper script"

STOP_FILE=~/stop.sh

if [ -f "$STOP_FILE" ]; then
  echo_warning "STOP: Looks like you already have the stop.sh script installed"
else
  cp "$SCRIPT_PATH/stop.sh" ~
  chmod +x ~/stop.sh
  if [ -x "$STOP_FILE" ]; then
    INSTALLED=true
    echo_success "STOP: stop.sh installed successfully"
  else
    ERROR=true
    echo_fail "STOP: Error unable to make stop.sh executable"
  fi
fi

# Checks to see if the alias already exists
if grep -qF "alias stop='~/stop.sh'" ~/.zshrc; then
  echo_warning "STOP: .zshrc alias already setup"
else
  # Add an alias to .zshrc
  echo "alias stop='~/stop.sh'" >> ~/.zshrc
  # Indicate that the .zshrc file needs to be reloaded
  INSTALLED=true
  echo_success "STOP: Alias added successfully"
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