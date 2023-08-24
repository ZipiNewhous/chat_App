# ./delete
# Build the image
docker build -t chat_app .

# Run the container
docker run -p 5000:5000 chat_app