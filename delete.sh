#!/bin/bash

# Check if the container exists
if [ "$(docker ps -a -q --filter ancestor=chat_app)" ]; then
  # Stop and delete the container
  docker stop $(docker ps -a -q --filter ancestor=chat_app)
  docker rm $(docker ps -a -q --filter ancestor=chat_app)
fi

# Check if the image exists
if [ "$(docker images -q chat_app)" ]; then
  # Delete the image
  docker rmi $(docker images -a -q --filter=reference='chat_app')
fi

