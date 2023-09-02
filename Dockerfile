# Start with the Python 3.8 slim image as the base
FROM python:3.8-slim
# set the working directory in the container
WORKDIR /code
# Set an environment variable to specify the path to the rooms directory
ENV PATH_ROOMS "./rooms"
# Set the Flask environment to development
ENV FLASK_ENV=development
# copy the dependencies file to the working directory
COPY requirements.txt .
# Install the Python dependencies from the requirements.txt file
RUN pip install -r requirements.txt
# copy the content of the templates directory to the working directory
COPY / .
# Add a health check to ensure the container is running correctly
HEALTHCHECK --interval=10s --timeout=3s CMD curl --fail http://localhost:5000/health || exit 1
# command to run on container start
CMD [ "python", "./chatApp.py"]
