#!/bin/bash
# Build the image
docker build -t chat_app -f bonus.dockerfile .

# # Run the container 
docker run -p 5000:5000 chat_app

# # Run the containet with limit to 2G
# docker run -it --ulimits nproc=1 --memory=2G chat_app

# Run the containet with limit to 1G
# docker run -it --ulimits nproc=1 --memory=1G chat_app



# # Prompt the user for the Docker image version
# version=$1
# if [ -z "$version" ]; then
#   read -p "Enter the Docker image version: " version
# fi


# # Pull the Docker image from DockerHub
# docker pull zipinewhous/chat_app:$version

# # Run a container based on the pulled image
# docker run --name chat_app zipinewhous/chat_app:$version