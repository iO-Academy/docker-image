#!/bin/zsh

FILE=~/phpunit.sh

if [ -f "$FILE" ]; then
  echo "Looks like you've already ran this install script!"
else
  mv phpunit.sh ~
  chmod +x ~/phpunit.sh
  echo "alias phpunit='~/phpunit.sh'" >> ~/.zshrc
  source ~/.zshrc
fi