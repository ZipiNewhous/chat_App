#!/bin/bash

# Check if the image exists
if [ "$(docker images -q chat_app)" ]; then
  # Delete the image
  docker image rm chat_app
fi

# Check if the container exists
if [ "$(docker ps -a -q --filter ancestor=chat_app)" ]; then
  # Delete the container
  docker rm $(docker ps -a -q --filter ancestor=chat_app)
fi


