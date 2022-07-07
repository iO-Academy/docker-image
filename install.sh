#!/bin/zsh

PHPUNIT_FILE=~/phpunit.sh

if [ -f "$PHPUNIT_FILE" ]; then
  echo "Looks like you've already ran this installer"
else
  cp phpunit.sh ~
  chmod +x ~/phpunit.sh
  echo "alias phpunit='~/phpunit.sh'" >> ~/.zshrc
  source ~/.zshrc
fi

COMPOSER_FILE=~/composer.sh

if [ -f "$COMPOSER_FILE" ]; then
  echo "Looks like you've already ran this installer"
else
  cp composer.sh ~
  chmod +x ~/composer.sh
  echo "alias composer='~/composer.sh'" >> ~/.zshrc
  source ~/.zshrc
fi