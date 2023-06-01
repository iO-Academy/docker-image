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

phpfile='~/php.sh'
if [ -f $phpfile ]; then
   rm "$phpfile"
   
fi

composerfile='~/composer.sh'
if [ -f $composerfile ]; then
   rm "$composerfile"
fi

phpunitfile='~/phpunit.sh'
if [ -f $phpunitfile ]; then
   rm "$phpunitfile"
fi

# TODO: Figure out how to remove aliases as well

# Save as docker-destroy-all.sh
# Run in academyServer directory with ./docker-destroy-all.sh
