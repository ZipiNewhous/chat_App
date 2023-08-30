#!/bin/bash

version=$1
commit_hash=$2

# if have time, check validate

# Get the version and commit hash from the user
if [ -z "$version" ]; then
  read -p "enter version: " version
fi

if [ -z "$commit_hash" ]; then
  read -p "enter commit hash: " commit_hash
fi

# Tag the image
echo "Tagging the image..."
docker tag "$version" "$commit_hash"

# Push the image to the repository
echo "Pushing the image to GitHub..."
docker push origin "$version"
docker push chat_app:latest

# # Build the image
docker build -t "chat_app:$version" .


# Handle errors
if [ "$?" -ne 0 ]; then
  echo "There was an error deploying the image."
  exit 1
fi

