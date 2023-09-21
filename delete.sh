# #!/bin/bash


# # Prompt the user for the Docker image version
# version=$1
# if [ -z "$version" ]; then
#   read -p "Enter version to delete: " version
# fi

# # Stop and remove the container if it is running
# if docker ps -a --format '{{.Names}}' | grep -q '^chat_app$'; then
#   docker stop chat_app
#   docker rm chat_app
# fi

# # Remove the Docker image if it exists
# if docker images --format '{{.Repository}}:{{.Tag}}' | grep -q "^zipinewhous/chat_app:$version$"; then
#   docker rmi zipinewhous/chat_app:$version
# fi



# Check if the container exists
if [ "$(docker ps -a -q --filter ancestor=chat_app)" ]; then
  # Stop and delete the container
  docker stop $(docker ps -a -q --filter ancestor=chat_app)
  docker rm $(docker ps -a -q --filter ancestor=chat_app)
fi

# Check if the image exists
if [ "$(docker images -q chat_app)" ]; then
  # Delete the image
  docker rmi $(docker images -a -q --filter=reference="zipinewhous/chat_app:$version")
fi

