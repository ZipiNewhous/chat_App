#!/bin/bash

# docker build -t chat_app -f thin.Dockerfile .
# docker run -p 5000:5000 chat_app

version='latest'
if [ $# -ne 0 ]; then
  version=$1
fi

# version=$1
# if [ -z "$version" ]; then
#   read -p "enter version: " version
# fi

docker volume create chat-app-data
docker build -t chat_app:${version} .
docker run -v chat-app-data:/code/data -p 5000:5000 --name chat-App-run chat_app:${version}
