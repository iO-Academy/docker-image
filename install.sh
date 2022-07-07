#!/bin/zsh

PHPUNIT_FILE=~/phpunit.sh

INSTALLED=false

if [ -f "$PHPUNIT_FILE" ]; then
  echo "Looks like you already have the phpunit script installed"
else
  cp phpunit.sh ~
  chmod +x ~/phpunit.sh
  echo "alias phpunit='~/phpunit.sh'" >> ~/.zshrc
  INSTALLED=true
fi

COMPOSER_FILE=~/composer.sh

if [ -f "$COMPOSER_FILE" ]; then
  echo "Looks like you already have the composer script installed"
else
  cp composer.sh ~
  chmod +x ~/composer.sh
  echo "alias composer='~/composer.sh'" >> ~/.zshrc
  INSTALLED=true
fi

PHP_FILE=~/php.sh

if [ -f "$PHP_FILE" ]; then
  echo "Looks like you already have the php script installed"
else
  cp php.sh ~
  chmod +x ~/php.sh
  echo "alias php='~/php.sh'" >> ~/.zshrc
  INSTALLED=true
fi

if $INSTALLED; then
    source ~/.zshrc
    clear
    echo "Install completed"
else
  echo "No install needed"
fi