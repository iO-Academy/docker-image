#!/bin/zsh

mv phpunit.sh ~
chmod +x ~/phpunit.sh
echo "alias phpunit='~/phpunit.sh'" >> ~/.zshrc
source ~/.zshrc
