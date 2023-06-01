#!/bin/bash
# Stop all containers
containers=`docker ps -a -q`
if [ -n "$containers" ] ; then
        docker stop $containers
fi
# Delete all containers
containers=`docker ps -a -q`
if [ -n "$containers" ]; then
        docker rm -f -v $containers
fi
# Delete all images
images=`docker images -q -a`
if [ -n "$images" ]; then
        docker rmi -f $images
fi

# Delete shell script files
PHP_FILE=~/php.sh
if [ -f "$PHP_FILE" ]; then
   rm ~/php.sh
   
fi

COMPOSER_FILE=~/composer.sh
if [ -f "$COMPOSER_FILE" ]; then
   rm ~/composer.sh
fi

phpunitfile=~/phpunit.sh
if [ -f "$phpunitfile" ]; then
   rm ~/phpunit.sh
fi

# Remove aliases
cp ~/.zshrc ~/.zshrc_backup
echo "Backup of zshrc created: ~/.zshrc_backup"

sed "/alias php='~\/php.sh'/d" ~/.zshrc > ~/.zshrc_new
rm ~/.zshrc
mv ~/.zshrc_new ~/.zshrc
echo "PHP alias removed"

sed "/alias composer='~\/composer.sh'/d" ~/.zshrc > ~/.zshrc_new
rm ~/.zshrc
mv ~/.zshrc_new ~/.zshrc
echo "Composer alias removed"

sed "/alias phpunit='~\/phpunit.sh'/d" ~/.zshrc > ~/.zshrc_new
rm ~/.zshrc
mv ~/.zshrc_new ~/.zshrc
echo "PHPUnit alias removed"

# Reload the config
exec /bin/zsh

# Save as docker-destroy-all.sh
# Run in academyServer directory with ./docker-destroy-all.sh
