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

# # # Build the image
# docker build -t "$version" .

# # Tag the git
# echo "Tagging the image..."
# git tag "v$version" "$commit_hash"

# # Push the image to the git repository
# echo "Pushing the image to GitHub..."
# git push "origin v$version"
# # git push latest

# # Tag the image with the version +V
# docker tag ${version} v${version}

# # Push the image to the  docker repository
# docker push zipinewhous/chat_app:${version}




# # צור תמונה בשם ה-commit hash
# docker build -t $version .

# # צור תג חדש
# git tag v$version $commit_hash

# # דחיפה לתוך ה TAG את את השינויים לפי ה COMMIT HASH
# git push --follow-tags origin v$version

# # צור DOCKER TAG בשם ה-VERSION
# docker tag $version zipinewhous/chat_app:$version

# # דחיפה למאגר
# docker push zipinewhous/chat_app:${version}




# Build the image
docker build -t $version .

# Tag the app and the image
git tag v$version $commit_hash
docker tag $version zipinewhous/chat_app:$version

# Push the image to the repository
git push --follow-tags origin v$version
docker push zipinewhous/chat_app:${version}





# Handle errors
if [ "$?" -ne 0 ]; then
  echo "There was an error deploying the image."
  exit 1
fi

