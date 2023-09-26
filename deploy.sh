#!/bin/bash

version=$1
commit_hash=$2
img_name=chat_app:${version}

# if have time, check validate

# Get the version and commit hash from the user
if [ -z "$version" ]; then
  read -p "enter version: " version
fi

if [ -z "$commit_hash" ]; then
  read -p "enter commit hash: " commit_hash
fi

if [[ "$(docker images -q $img_name)" ]]; then
  read -p "Image $img_name already exists. Do you want to rebuild it (y/n)? " rebuild
  # If the user chooses to rebuild the image, delete the existing one.
  if [[ "$rebuild" == "y" ]]; then
    docker rmi $img_name
  fi
fi

# Build the image
docker build -t $img_name .

# Tag the app and the image
git tag v$version $commit_hash
docker tag $version saraleShasha/chat_app:$version

# Push the image to the repository
git push --follow-tags origin v$version
docker push saraleShasha/chat_app:${version}


# Handle errors
if [ "$?" -ne 0 ]; then
  echo "There was an error deploying the image."
  exit 1
fi

