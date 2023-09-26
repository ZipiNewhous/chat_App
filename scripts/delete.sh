#!/bin/bash

# #Deleting all images
# docker rmi -f $(docker images -aq)

# # Deleting all containers
# docker rm -f $(docker rm -aq)


#According to Task 9 

if [ -z "$1" ]; then
  read -p "Please provide the version to delete as a parameter" version
fi

version=$1

# Stop and remove the Docker container using the provided version
docker stop chat_app-$version
docker rm chat_app-$version

# Delete the Docker image using the provided version
docker rmi chat_app:$version